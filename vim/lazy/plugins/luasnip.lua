return {
	-- Asegúrate de tener LuaSnip instalado
	{
		"L3MON4D3/LuaSnip",
		config = function()
			local luasnip = require("luasnip")
			-- Carga snippets desde tu directorio
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/projects/swissknife/vim/snippets/luasnippets/" })
			-- Saltar hacia adelante en los nodos
			-- Mapeo para <Tab>
			vim.keymap.set({ "i", "s" }, "<Tab>", function()
				local luasnip = require("luasnip")
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					-- Inserta una tabulación normal si no estás en un snippet
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, { silent = true })
			-- Saltar hacia atrás en los nodos
			-- Mapeo para <S-Tab>
			vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					-- Retrocede una tabulación si no estás en un snippet
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-d>", true, false, true), "n", false)
				end
			end, { silent = true })
			-- Expandir nodos
			-- Mapeo para <C-k>
			vim.keymap.set("i", "<C-k>", function()
				if require("luasnip").expand_or_jumpable() then
					require("luasnip").expand_or_jump()
				end
			end, { silent = true })
			-- end
		end,
		build = "make install_jsregexp",
		tag = "v2.4.0",
	},
}
