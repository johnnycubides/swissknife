"""Offline CLI regression tests. Real conversion/browser checks are separate."""

import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


SCRIPT = Path(__file__).with_name("md2reveal")
CHECKSUM = "359b575dd51bbda32f89b2fd4c7dc46ad7389a805572158916c29252f7a27333"


class Md2RevealTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.input = self.root / "source with spaces" / "talk.md"
        self.input.parent.mkdir()
        self.input.write_text("# Test\n\n::: notes\nSpeaker notes.\n:::\n")
        self.bin = self.root / "bin"
        self.bin.mkdir()
        pandoc = self.bin / "pandoc"
        pandoc.write_text(
            "#!/usr/bin/env python3\n"
            "import json, os, pathlib, sys\n"
            "pathlib.Path(os.environ['CAPTURE']).write_text(json.dumps(sys.argv[1:]))\n"
            "if os.environ.get('FAIL_PANDOC'): sys.exit(2)\n"
            "output = next(a.split('=', 1)[1] for a in sys.argv if a.startswith('--output='))\n"
            "pathlib.Path(output).write_text('<html>test</html>')\n"
        )
        pandoc.chmod(0o755)
        curl = self.bin / "curl"
        curl.write_text("#!/bin/sh\necho 'Unexpected network request' >&2\nexit 99\n")
        curl.chmod(0o755)
        self.capture = self.root / "arguments.json"
        self.env = {**os.environ, "PATH": str(self.bin) + ":" + os.environ["PATH"],
                    "CAPTURE": str(self.capture)}

    def run_script(self, *args):
        return subprocess.run(["bash", str(SCRIPT), *map(str, args)],
                              env=self.env, text=True, capture_output=True)

    def test_help_and_invalid_input(self):
        self.assertEqual(self.run_script().returncode, 0)
        for args in [("--unknown",), ("missing.md",), (self.input, self.input),
                     (self.input, "one.html", "two.html")]:
            with self.subTest(args=args):
                self.assertNotEqual(self.run_script(*args).returncode, 0)
        self.assertTrue(self.input.read_text().startswith("# Test"))

    def test_standalone_arguments_and_default_destination(self):
        result = self.run_script(self.input)
        self.assertEqual(result.returncode, 0, result.stderr)
        args = json.loads(self.capture.read_text())
        self.assertIn("--embed-resources", args)
        self.assertIn("--to=revealjs", args)
        self.assertIn("--slide-level=1", args)
        self.assertIn("--variable=center:true", args)
        self.assertTrue(self.input.with_suffix(".html").exists())
        self.assertFalse((self.input.parent / "assets").exists())

    def test_vertical_alignment_can_be_overridden(self):
        self.env["REVEAL_CENTER"] = "false"
        result = self.run_script(self.input)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("--variable=center:false", json.loads(self.capture.read_text()))

    def test_assets_reused_for_two_presentations_without_network(self):
        output = self.root / "output with spaces"
        runtime = output / "assets" / "reveal.js-5.2.1"
        for name in ["dist/reveal.js", "dist/reveal.css", "plugin/notes/notes.js"]:
            path = runtime / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.touch()
        (runtime / ".md2reveal-sha256").write_text(CHECKSUM + "\n")
        for name in ["first", "second"]:
            result = self.run_script("--assets", self.input, output / f"{name}.html")
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("Reusing:", result.stdout)
            args = json.loads(self.capture.read_text())
            self.assertNotIn("--embed-resources", args)
            self.assertIn(f"--extract-media=assets/media/{name}", args)
            self.assertIn("--variable=revealjs-url:assets/reveal.js-5.2.1", args)
            self.assertTrue((output / f"{name}.html").exists())
        self.assertTrue((output / "assets/md2reveal.css").exists())

    def test_unmanaged_assets_are_not_overwritten(self):
        runtime = self.root / "assets/reveal.js-5.2.1"
        runtime.mkdir(parents=True)
        keep = runtime / "existing.txt"
        keep.write_text("Keep this content.")
        result = self.run_script("--assets", self.input, self.root / "talk.html")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("incomplete or not managed", result.stderr)
        self.assertEqual(keep.read_text(), "Keep this content.")

    def test_pandoc_failure_does_not_report_success(self):
        self.env["FAIL_PANDOC"] = "1"
        result = self.run_script(self.input)
        self.assertEqual(result.returncode, 2)
        self.assertNotIn("Generated:", result.stdout)


if __name__ == "__main__":
    unittest.main()
