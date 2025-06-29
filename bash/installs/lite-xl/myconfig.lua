local lsp = require("plugins.lsp")

local function get_verible_path()
	local verible_path = "/home/" .. os.getenv("USER") .. "/miniconda3/envs/digital/bin/verible-verilog-ls"
	local file = io.open(verible_path, "r")
	if file then
		file:close()
		return verible_path
	else
		return "verible-verilog-ls"
	end
end

-- https://github.com/lite-xl/lite-xl-lsp
lsp.add_server({
	name = "verible",
	language = "Verilog",
	file_patterns = { "%.v$" },
	command = { get_verible_path(), "--rules=-unpacked-dimensions-range-ordering,-always-comb" },
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
