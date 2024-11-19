return {
	-- Asegúrate de tener LuaSnip instalado
	{
		"L3MON4D3/LuaSnip",
		config = function()
			local luasnip = require("luasnip")
			-- Carga snippets desde tu directorio
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/projects/swissknife/vim/snippets/luasnippets/" })
		end,
	},
}
