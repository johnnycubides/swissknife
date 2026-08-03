local lsp = require("plugins.lsp")

local function get_verible_path()
	local home = os.getenv("HOME")
	local verible_root = os.getenv("VERIBLE_ROOT")
	local verible_paths = {}

	if verible_root then
		table.insert(verible_paths, verible_root .. "/bin/verible-verilog-ls")
	end

	if home then
		table.insert(
			verible_paths,
			home .. "/gitPackages/digital-logic-design-tools/verible-v0.0-4084-gf3e4d98b/bin/verible-verilog-ls"
		)
		table.insert(verible_paths, home .. "/miniconda3/envs/digital/bin/verible-verilog-ls")
	end

	for _, verible_path in ipairs(verible_paths) do
		local file = io.open(verible_path, "r")
		if file then
			file:close()
			return verible_path
		end
	end

	return "verible-verilog-ls"
end

-- https://github.com/lite-xl/lite-xl-lsp
lsp.add_server({
	name = "verible-verilog",
	language = "verilog",
	file_patterns = { "%.v$", "%.vh$" },
	command = { get_verible_path(), "--rules=-unpacked-dimensions-range-ordering,-always-comb" },
	incremental_changes = false,
	verbose = false,
})

lsp.add_server({
	name = "verible-systemverilog",
	language = "systemverilog",
	file_patterns = { "%.sv$", "%.svh$" },
	command = { get_verible_path() },
	incremental_changes = false,
	verbose = false,
})

-- mod-version:3
-- https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/copyfilelocation.lua
local core = require("core")
local command = require("core.command")

command.add("core.docview", {
	["copy-file-location:copy-file-location"] = function(dv)
		local doc = dv.doc
		if not doc.abs_filename then
			core.error("Cannot copy location of unsaved doc")
			return
		end
		core.log('Copying to clipboard "%s"', doc.abs_filename)
		system.set_clipboard(doc.abs_filename)
	end,
})
