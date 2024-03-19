local function file_exists(file)
	local f = io.open(file, "r")
	if f then
		f:close()
		return true
	else
		return false
	end
end

if file_exists("./pro.vim") then
	print("existe ./pro.vim")
	vim.cmd("source ./pro.vim")
elseif file_exists("./.pro.vim") then
	print("existe ./.pro.vim")
	vim.cmd("source ./.pro.vim")
end

-- Configuración para el plugin de verible
require("config.verible_lsp_config")

-- https://github.com/smjonas/snippet-converter.nvim/blob/main/doc/documentation.md#luasnip
require("luasnip.loaders.from_vscode").load({ paths = "~/projects/swissknife/vim/snippets/ultisnips2luasnip" })

-- Config my snippets
require("luasnip.loaders.from_lua").load({ paths = "~/projects/swissknife/vim/snippets/luasnippets" })
