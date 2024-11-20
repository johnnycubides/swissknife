local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function copy(args, parent, user_args)
	if user_args[1] then
		return args[1][1] .. user_args[1]
	end
	return args[1][1]
end

local tbb = s(
	{ trig = "tb" },
	{ t("hola"), i(1), f(copy, { 1 }, { user_args = { "mundo" } }), i(2, "text"), t({ "hpla" }) }
)

local function repeat_node(
	args, -- text from i(x_argument)
	_, -- parent
	text_after,
	text_before
)
	local ret = args[1][1]
	if text_after then
		ret = ret .. text_after
	end
	if text_before then
		ret = text_before .. ret
	end
	return ret
end

local tb = s({ trig = "tb" }, {
	t({ "// filename: " }),
	i(1, "top"),
	t({
		"_tb.v",
		"// brief: testbench de un blink para la placa de desarrollo Blackice",
		"// la cual tienen un reloj de hardware de 25 MHz (periodo 40 nS)",
		"",
		"// CONFIGURACIÓN DEL TIMESCALE",
		"// Tenga encuenta que: solo puede usar los enteros 1, 10, 100 en la escala de",
		"// s, ms, us, ns, ps, fs.",
		"// Para el time_unit se hará uso de 10 nS, en vista del perido del clock. el",
		"// time_precision, se pone según interés",
		"`timescale 10ns / 10ns  // <time_unit>/<time_precision",
		"",
		"// CONFIGURACIÓN DE LOS PARÁMETROS DEL RELOJ",
		"// Cada estado de reloj debe durar medio periodo, para este caso sería 20 nS,",
		"// como el time_unit es de 10 ns, entonces con 2 tiempos se puede representar",
		"// la duración de cada reloj.",
		"`ifndef TIME_UNIT",
		"`define TIME_UNIT 2",
		"`endif",
		"",
	}),
	-- f(repeat_node, { 1 }),
	f(repeat_node, { 1 }, { user_args = { '.v"', '`include "./' } }),
	t({ "", "module " }),
	f(repeat_node, { 1 }, { user_args = { "_tb;" } }),
	t({
		"",
		"\t// Determinar el tamaño de los wire como de los estímulos",
		"\tparameter integer INPUT_SIZE = 1;",
		"\tparameter integer OUTPUT_SIZE = 1;",
		"",
		"\t// STIMULUS 1",
		"\treg [INPUT_SIZE-1:0] inputs;",
		"\tinitial begin",
		" \t\tinputs = 0;",
		"\t\t#(`TIME_UNIT * 1) inputs = 1;",
		"\t\t#(`TIME_UNIT * 1) $finish();  // [stop(), $finish()]",
		"\tend",
	}),
	t({
		"",
		"\t// // Make a regular pulsing clock.",
		"\t// reg clk = 0;",
		"\t// always #(`TIME_UNIT) clk = !clk;",
		"\t//",
		"\t// // CLOCK STIMULUS",
		"\t// initial begin",
		"\t//   #(`TIME_UNIT * 32) $finish();  // [stop(), $finish()]",
		"\t// end",
		"",
		"\t// initial",
		"\t// begin",
		"\t//   #2E9 $finish(); // [stop(), $finish()]",
		"\t// end",
		"",
		"\t// // STIMULUS 1",
		"\t// reg a = 0, b = 0;",
		"\t// initial begin",
		"\t//   #(`TIME_UNIT * 17) a = 1;",
		"\t//   b = 1;",
		"\t//   #(`TIME_UNIT * 11) a = 1;",
		"\t//   b = 0;",
		"\t//   #(`TIME_UNIT * 29) a = 1;",
		"\t//   b = 1;",
		"\t//   #(`TIME_UNIT * 11) a = 1;",
		"\t//   b = 0;",
		"\t//   #(`TIME_UNIT * 100) $finish();  // [stop(), $finish()]",
		"\t// end",
		"",
		"\t// // STIMULUS 2",
		"\t// reg [INPUT_SIZE-1:0] inputs;",
		"\t// // inputs[2] inputs[1] inputs[1]",
		"\t// integer i;",
		"\t// initial",
		"\t// begin",
		"\t//   // inputs = 0;",
		"\t//   for (i=0; i<2**INPUT_SIZE; i=i+1) // 2 elevado a la INPUT_SIZE , en el ejemplo 2^3 = 8 combinaciones*/",
		"\t//   begin */",
		"\t//     inputs = i;",
		"\t// #(`TIME_UNIT * 1 );",
		"\t//   end",
		"\t// end",
		"",
		"\t// // STIMULUS ARGS",
		"\t// initial",
		"\t// begin",
		'\t//   if(! $value$plusargs("inputs=%b", inputs)) begin',
		'\t//     $display("ERROR: please specify +inputs=<value> to start.");',
		"\t//     $finish;",
		"\t//   end",
		"",
		'\t//   wait (outs) $display("outs = %d", outs);',
		"\t//   #1",
		"\t//   $finish;",
		"\t// end",
		"",
		"\t// RESULT FOR DEVICE/DESIGN UNDER TEST",
		"\twire [OUTPUT_SIZE-1:0] probe;",
		"",
		"\t// DEVICE/DESIGN UNDER TEST",
		"\ttop dut (",
		"\t\t.a(inputs),",
		"\t\t.y(probe)",
		"\t);",
		"",
		"\t// MONITOR",
		'\tinitial $monitor("Time: %t, out = %d", $time, probe);',
		"",
		"\t// WAVES IN VCD TO OPEN IN GTKWAVE",
		"\tinitial begin",
		"",
	}),
	f(repeat_node, { 1 }, { user_args = { "_tb);", "\t\t$dumpvars(0, " } }),
	t({
		"",
		"\tend",
		"endmodule",
	}),
})

ls.add_snippets("verilog", { tb })
