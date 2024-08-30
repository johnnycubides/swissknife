-- :CmpStatus
-- https://www.reddit.com/r/neovim/comments/15w5itv/nvim_lsp_in_unknown_source_names_in_cmpstatus/
return {
	-- ... otros complementos
	{
		"hrsh7th/nvim-cmp", -- Complemento principal
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- Complemento para completar desde buffers
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			-- ... otros complementos de fuentes si los necesitas
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip" },
					{
						name = "buffer",
						option = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs() -- Obtiene todos los buffers abiertos
							end,
						},
					}, -- Permite completar desde buffers
				},
				mapping = {
					-- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
					-- ["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Selecciona el ítem
				},
				-- Configuraciones adicionales si son necesarias
			})
		end,
	},
	-- ... otros complementos
}
