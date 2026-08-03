-- mod-version:3
local syntax = require("core.syntax")

local symbols = {}

local function add_symbols(words, symbol_type)
	for word in words:gmatch("%S+") do
		symbols[word] = symbol_type
	end
end

-- Reserved words from IEEE 1800-2017, excluding data and net types below.
add_symbols([[
	accept_on alias always always_comb always_ff always_latch and assert assign assume
	automatic before begin bind bins binsof break buf bufif0 bufif1 case casex casez
	cell checker class clocking cmos config constraint context continue cover covergroup
	coverpoint cross deassign default defparam design disable dist do edge else end
	endcase endchecker endclass endclocking endconfig endfunction endgenerate endgroup
	endinterface endmodule endpackage endprimitive endprogram endproperty endsequence
	endspecify endtable endtask enum eventually expect export extends extern final
	first_match for force foreach forever fork forkjoin function generate genvar global
	highz0 highz1 if iff ifnone ignore_bins illegal_bins implements implies import
	incdir include initial inout input inside instance interconnect interface intersect
	join join_any join_none large let liblist library local localparam macromodule matches
	medium modport module nand negedge nettype new nexttime nmos nor noshowcancelled not
	notif0 notif1 or output package packed parameter pmos posedge primitive priority
	program property protected pull0 pull1 pulldown pullup pulsestyle_ondetect
	pulsestyle_onevent pure rand randc randcase randsequence rcmos ref reject_on release
	repeat restrict return rnmos rpmos rtran rtranif0 rtranif1 s_always s_eventually
	s_nexttime s_until s_until_with scalared sequence showcancelled small soft solve
	specify specparam static strong strong0 strong1 struct super sync_accept_on
	sync_reject_on table tagged task this throughout timeprecision timeunit tran tranif0
	tranif1 typedef union unique unique0 until until_with untyped use vectored virtual
	wait wait_order weak weak0 weak1 while wildcard with within xnor xor
]], "keyword")

add_symbols([[
	bit byte chandle const event int integer logic longint real realtime reg shortint
	shortreal signed string supply0 supply1 time tri tri0 tri1 triand trior trireg type
	unsigned uwire var void wand wire wor
]], "keyword2")

add_symbols("null", "literal")

syntax.add({
	name = "SystemVerilog",
	files = { "%.sv$", "%.svh$" },
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
		{ regex = [=['[01xXzZ]]=], type = "number" },

		-- Real, exponent, and decimal integer literals.
		{ regex = [[(?:\d[\d_]*\.\d[\d_]*|\.\d[\d_]+|\d[\d_]*\.)(?:[eE][+-]?\d[\d_]*)?]], type = "number" },
		{ regex = [[\d[\d_]*[eE][+-]?\d[\d_]*]], type = "number" },
		{ regex = [[\d[\d_]*]], type = "number" },

		-- Compiler directives, macro calls, system tasks, and escaped identifiers.
		{ regex = [[`[A-Za-z_][A-Za-z0-9_$]*]], type = "keyword" },
		{ regex = [[\$[A-Za-z_][A-Za-z0-9_$]*]], type = "function" },
		{ regex = [[\\\S+]], type = "symbol" },

		{ regex = [[(?:\|->|\|=>|#-#|#=#|##|===|!==|==\?|!=\?|<<<?|>>>?|\*\*|::|:=|:/|->|=>|\+\+|--)]], type = "operator" },
		{ pattern = "[%+%-=/%*%^%%<>!~|&?:@#]", type = "operator" },
		{ pattern = "[%a_][%w_$]*%f[(]", type = "function" },
		{ pattern = "[%a_][%w_$]*", type = "symbol" },
	},
	symbols = symbols,
})
