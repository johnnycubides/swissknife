local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local handlers = {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup({})
	end,
	-- VOLAR: no activar esta opción, en cambio hacer uso de (1)
	["volar"] = function()
		lspconfig.volar.setup({
			filetypes = { "vue" },
			init_options = {
				vue = {
					hybridMode = true,
				},
			},
		})
	end,
	-- tsserver con soporte vue, no funciona correctamente
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
	["lua_ls"] = function() end,
}
mason_lspconfig.setup({
	ensure_installed = { "lua_ls" },
	handlers = handlers,
	automatic_installation = false,
})

-- (1) VOLAR CONFIGURACIÓN
-- Se requiere instalar manualmente:
-- -- npm install -g @vue/language-server @vue/typescript-plugin typescript
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.volar.setup({
	filetypes = { "vue" },
	init_options = {
		vue = {
			hybridMode = false,
		},
	},
	capabilities = capabilities,
})

-- 27-08-2024
-- https://chipsalliance.github.io/verible/lint.html
lspconfig.verible.setup({
	filetypes = { "verilog", "systemverilog" },
	cmd = { "/home/johnny/miniconda3/envs/digital/bin/verible-verilog-ls" },
	-- cmd = { "verible-verilog-ls", "--ruleset=all" },
	-- cmd = { "verible-verilog-ls" },
	root_dir = function()
		return vim.loop.cwd()
	end,
})
