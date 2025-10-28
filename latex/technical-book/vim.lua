local function build()
	vim.cmd("mak! build")
end
local function view()
	vim.cmd("mak! view &")
end
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap = true, silent = true }
local opts_prj = { makeprg = "just" }

for key, value in pairs(opts_prj) do
	vim.opt[key] = value
end
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<F5>", build, { desc = "Build project", noremap = true, silent = true })
vim.keymap.set("n", "<F6>", view, { desc = "View object" })
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
