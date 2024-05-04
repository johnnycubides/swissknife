local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local handlers = {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup({})
	end,
	-- VOLAR
	["volar"] = function()
		lspconfig.volar.setup({
			filetypes = { "vue" },
			init_options = {
				vue = {
					hybridMode = true,
				},
				-- typescript = {
				-- 	tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
				-- },
			},
			-- settings = {
			-- 	vue = {
			-- 		diagnostics = {
			-- 			globals = { "vim" },
			-- 		},
			-- 	},
			-- },
		})
	end,
	["tsserver"] = function()
		-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vue-support
		lspconfig.tsserver.setup({
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "~/.nvm/versions/node/v21.7.3/lib/node_modules/@vue/typescript-plugin",
						languages = { "vue" },
					},
				},
			},
			filetypes = {
				"vue",
			},
		})
	end,
}
mason_lspconfig.setup({
	ensure_installed = { "volar" },
	handlers = handlers,
	automatic_installation = false,
})
-- local capabilities =
-- 	require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local lspconfig = require("lspconfig")
-- lspconfig.volar.setup({
-- 	filetypes = { "vue" },
-- 	init_options = {
-- 		vue = {
-- 			hybridMode = false,
-- 		},
-- 	},
-- 	capabilities = capabilities,
-- })
