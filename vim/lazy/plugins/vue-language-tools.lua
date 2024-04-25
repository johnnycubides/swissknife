-- Este plugin sirve tanto para vue, javascript y typescript. Se recomienda no hacer uso
-- del script ./typescript-tools.lua pues este ya lo contiene
-- npm install -g @vue/language-server @vue/typescript-plugin typescript-language-server typescript
return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local mason_registry = require("mason-registry")
			local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
				.. "/node_modules/@vue/language-server"
			-- local vue_language_server_path =
			-- 	"/home/johnny/.nvm/versions/node/v21.7.3/lib/node_modules/@vue/language-server"

			local lspconfig = require("lspconfig")

			lspconfig.tsserver.setup({
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
				},
				-- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				filetypes = { "vue" },
			})

			-- No need to set `hybridMode` to `true` as it's the default value
			lspconfig.volar.setup({})
		end,
	},
}
