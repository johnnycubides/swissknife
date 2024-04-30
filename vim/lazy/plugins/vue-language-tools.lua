-- npm install -g @vue/language-server @vue/typescript-plugin typescript
return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- https://github.com/williamboman/mason-lspconfig.nvim/issues/371
			-- https://github.com/Jarmos-san/dotfiles/blob/5cd6aa506d9888e4437340741def5833148cfba5/dotfiles/.config/nvim/lua/plugins/lspconfig.lua#L70
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local lspconfig = require("lspconfig")
			lspconfig.volar.setup({
				filetypes = { "vue" },
				init_options = {
					vue = {
						hybridMode = false,
					},
				},
				capabilities = capabilities,
			})
		end,
	},
}
