local lsp = require("plugins.lsp")

-- https://github.com/lite-xl/lite-xl-lsp
lsp.add_server({
	name = "verible",
	language = "Verilog",
	file_patterns = { "%.v$" },
	command = { "verible-verilog-ls", "--rules=-unpacked-dimensions-range-ordering,-always-comb" },
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
