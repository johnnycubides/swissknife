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
	{ t("hola"), i(1), f(copy, { 1 }, { user_args = { "mundo" } }), i(2, "text"), t({ "hola" }) }
)

-- Repeat a node
-- f(repeat_node, { numberNode }, { user_args = { "text_after", "text_before" } })
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

-- DOCS: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
-- Crear un array y recorrerlo con un for
local array_for = s({ trig = "bash_array_for" }, {
	i(1, "array_name"),
	t({ "=(" }),
	i(2, '"value1" "value2" "value3"'),
	t({ ")", "", "" }),
	t({ "for " }),
	i(3, "runner"),
	f(repeat_node, { 1 }, { user_args = { '[@]}" ; do', ' in "${' } }),
	t({ "", "" }),
	f(repeat_node, { 3 }, { user_args = { '"', 'echo "$' } }),
	t({ "", "done", "" }),
})

-- agregar a sh, sin embargo es bash
ls.add_snippets("sh", { array_for })
