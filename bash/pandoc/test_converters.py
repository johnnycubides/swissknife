"""Check conversion exit codes without generating real HTML or PDF files."""

import os
from pathlib import Path
import subprocess
import tempfile
import unittest


DIRECTORY = Path(__file__).resolve().parent
CONVERTERS = ("md2pdf", "rst2pdf", "md2html", "rst2html", "md2reveal")


class ConverterExitTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.bin = self.root / "bin"
        self.bin.mkdir()
        pandoc = self.bin / "pandoc"
        pandoc.write_text('#!/bin/sh\nexit "${PANDOC_TEST_EXIT:-0}"\n')
        pandoc.chmod(0o755)
        self.source = self.root / "input with spaces.md"
        self.source.write_text("Test document\n")
        self.env = {**os.environ, "PATH": str(self.bin) + ":" + os.environ["PATH"]}

    def run_converter(self, name):
        return subprocess.run(["bash", str(DIRECTORY / name), str(self.source)],
                              env=self.env, capture_output=True, text=True)

    def test_pandoc_error_is_propagated_without_success_message(self):
        self.env["PANDOC_TEST_EXIT"] = "43"
        for name in CONVERTERS:
            with self.subTest(converter=name):
                result = self.run_converter(name)
                self.assertEqual(result.returncode, 43, result.stderr)
                self.assertNotIn("Generated:", result.stdout)

    def test_success_is_reported_after_pandoc_succeeds(self):
        self.env["PANDOC_TEST_EXIT"] = "0"
        for name in CONVERTERS:
            with self.subTest(converter=name):
                result = self.run_converter(name)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertIn("Generated:", result.stdout)

    def test_help_does_not_require_pandoc_to_succeed(self):
        self.env["PANDOC_TEST_EXIT"] = "43"
        for name in CONVERTERS:
            with self.subTest(converter=name):
                result = subprocess.run(["bash", str(DIRECTORY / name), "--help"],
                                        env=self.env, capture_output=True, text=True)
                self.assertEqual(result.returncode, 0)
                self.assertIn("Usage:", result.stdout)


if __name__ == "__main__":
    unittest.main()
