local lsp = require("plugins.lsp")

lsp.add_server({
	name = "verible",
	language = "Verilog",
	file_patterns = { "%.v$" },
	command = { "verible-verilog-ls" },
	incremental_changes = false,
	verbose = false,
})
