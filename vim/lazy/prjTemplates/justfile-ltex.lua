local function view()
	vim.cmd("just view")
end
local function help()
	vim.cmd("just clean")
end
local function build()
	vim.cmd("just build")
end
-- vim.opt_global.makeprg = "just"
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<F5>", build, { desc = "Build project" })
vim.keymap.set("n", "<F6>", view, { desc = "View project" })
vim.keymap.set("n", "<F7>", help, { desc = "Help project" })
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- -- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
-- vim.keymap.set("n", ",q", vim.diagnostic.setloclist, { desc = "Desplegar warnings" })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ltex
-- Al hacer uso de mason lspconfig se carga este archivo pro.lua que contiene la configuración
-- para el server ltex. En otro caso, si configura ltex fuera de mason, puede hacer uso del
-- archivo de configuración que se encuentra en ./.vim/coc-settings.json
local lspconfig = require("lspconfig")
lspconfig.ltex.setup({
	settings = {
		ltex = {
			language = "es",
			dictionary = {
				es = { "FPGA", "NOT", "HDL", "DUTY", "PWM" },
			},
		},
	},
})
