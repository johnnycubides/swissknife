-- comentarios vgc con //
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "verilog", "vue" },
	callback = function()
		vim.cmd("setlocal commentstring=//\\ %s")
	end,
})
