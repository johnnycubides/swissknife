-- Iniciar algunas funciones automáticamente en función del filetype
require("config.autocmd")

-- Configuración para el plugin de verible
require("config.verible_lsp_config")

-- Config snippets plugin
-- https://github.com/smjonas/snippet-converter.nvim/blob/main/doc/documentation.md#luasnip
-- plugin from_vscode
require("luasnip.loaders.from_vscode").load({ paths = "~/projects/swissknife/vim/snippets/ultisnips2luasnip" })
-- Config my snippets
require("luasnip.loaders.from_lua").load({ paths = "~/projects/swissknife/vim/snippets/luasnippets" })

local function file_exists(file)
	local f = io.open(file, "r")
	if f then
		f:close()
		return true
	else
		return false
	end
end

-- if file_exists("./pro.vim") then
-- 	print("existe ./pro.vim")
-- 	vim.cmd("source ./pro.vim")
-- elseif file_exists("./.pro.vim") then
-- 	print("existe ./.pro.vim")
-- 	vim.cmd("source ./.pro.vim")
-- end

if file_exists("./pro.lua") then
	print("existe ./pro.lua")
	require("./pro")
elseif file_exists("./.pro.lua") then
	print("existe ./.pro.lua")
	require("./.pro")
end
