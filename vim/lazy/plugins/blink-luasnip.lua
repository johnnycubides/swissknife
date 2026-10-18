-- Conecta el menú de Blink con los snippets registrados en LuaSnip.
-- Copiar a ~/.config/nvim/lua/plugins/ si esa es tu configuración activa.
-- Los snippets locales de cada proyecto siguen cargándose desde su vim.lua.
return {
	{
		"saghen/blink.cmp",
		opts = {
			snippets = {
				preset = "luasnip",
			},
		},
	},
}
