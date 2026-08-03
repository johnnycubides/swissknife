-- mod-version:3
local syntax = require("core.syntax")

local symbols = {}

local function add_symbols(words, symbol_type)
	for word in words:gmatch("%S+") do
		symbols[word] = symbol_type
	end
end

-- Reserved words from IEEE 1364-2005.
add_symbols([[
	always and assign automatic begin buf bufif0 bufif1 case casex casez cell cmos
	config deassign default defparam design disable edge else end endcase endconfig
	endfunction endgenerate endmodule endprimitive endspecify endtable endtask event
	for force forever fork function generate genvar highz0 highz1 if ifnone incdir
	include initial inout input instance join large liblist library localparam
	macromodule medium module nand negedge nmos nor noshowcancelled not notif0 notif1
	or output parameter pmos posedge primitive pull0 pull1 pulldown pullup
	pulsestyle_ondetect pulsestyle_onevent rcmos release repeat rnmos rpmos rtran
	rtranif0 rtranif1 scalared showcancelled small specify specparam strong0 strong1
	table task tran tranif0 tranif1 use vectored wait weak0 weak1 while xnor xor
]], "keyword")

add_symbols([[
	integer real realtime reg signed supply0 supply1 time tri tri0 tri1 triand trior
	trireg unsigned uwire wand wire wor
]], "keyword2")

syntax.add({
	name = "Verilog",
	files = { "%.v$", "%.vh$" },
	comment = "//",
	block_comment = { "/*", "*/" },
	patterns = {
		{ pattern = "//.*", type = "comment" },
		{ pattern = { "/%*", "%*/" }, type = "comment" },
		{ pattern = { '"', '"', "\\" }, type = "string" },

		-- Sized and unsized based integer literals.
		{ regex = [[(?:[1-9][\d_]*)?\s*'[sS]?[bB]\s*[xXzZ?01][xXzZ?01_]*]], type = "number" },
		{ regex = [[(?:[1-9][\d_]*)?\s*'[sS]?[oO]\s*[xXzZ?0-7][xXzZ?0-7_]*]], type = "number" },
		{ regex = [[(?:[1-9][\d_]*)?\s*'[sS]?[dD]\s*[xXzZ?0-9][xXzZ?0-9_]*]], type = "number" },
		{ regex = [[(?:[1-9][\d_]*)?\s*'[sS]?[hH]\s*[xXzZ?0-9a-fA-F][xXzZ?0-9a-fA-F_]*]], type = "number" },

		-- Real, exponent, and decimal integer literals.
		{ regex = [[(?:\d[\d_]*\.\d[\d_]*|\.\d[\d_]+|\d[\d_]*\.)(?:[eE][+-]?\d[\d_]*)?]], type = "number" },
		{ regex = [[\d[\d_]*[eE][+-]?\d[\d_]*]], type = "number" },
		{ regex = [[\d[\d_]*]], type = "number" },

		-- Compiler directives, macro calls, system tasks, and escaped identifiers.
		{ regex = [[`[A-Za-z_][A-Za-z0-9_$]*]], type = "keyword" },
		{ regex = [[\$[A-Za-z_][A-Za-z0-9_$]*]], type = "function" },
		{ regex = [[\\\S+]], type = "symbol" },

		{ pattern = "[%+%-=/%*%^%%<>!~|&?:@#]", type = "operator" },
		{ pattern = "[%a_][%w_$]*%f[(]", type = "function" },
		{ pattern = "[%a_][%w_$]*", type = "symbol" },
	},
	symbols = symbols,
})
