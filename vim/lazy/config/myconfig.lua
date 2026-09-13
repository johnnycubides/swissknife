-- Iniciar algunas funciones automáticamente en función del filetype
require("config.autocmd")
require("config.lsp-config")

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
elseif file_exists("./vim.lua") then
	print("existe ./vim.lua")
	require("./vim")
elseif file_exists("./.pro.lua") then
	print("existe ./.pro.lua")
	require("./.pro")
end

-- Cambio del color de la línea cuando se hace uso de Tokyo
-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "LightGreen" })
-- 		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "LightGreen" })
-- 		vim.api.nvim_set_hl(0, "SpellBad", {
-- 			fg = "white",
-- 			bg = "#5f0000",
-- 			bold = true,
-- 		})
-- 	end,
-- })

vim.api.nvim_create_user_command("SpellHighlight", function()
	vim.api.nvim_set_hl(0, "SpellBad", {
		underline = true,
		-- sp = "red",
		fg = "red",
		-- fg = "white",
		-- bg = "#5f0000",
		-- bold = true,
	})
end, {})

-- Poner en verde el marcador de número de línea
vim.api.nvim_create_user_command("HighlightLineNumber", function()
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "LightGreen" })
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "LightGreen" })
end, {})

-- #######################################################
-- START VERIBLE CONFIG TO VERILOG AND SYSTEMVERILOG FILES
-- #######################################################-
local function get_verible_bin()
	-- Intenta encontrar 'verible-verilog-ls' en el PATH
	local handle = io.popen("which verible-verilog-ls")
	local result = handle:read("*a")
	handle:close()
	-- Si se encuentra en el PATH, usa ese comando
	if result ~= "" then
		return "verible-verilog-ls"
	else
		local user = os.getenv("USER")
		-- Si no se encuentra, usa la ruta absoluta
		return "/home/"
			.. user
			.. "/gitPackages/digital-logic-design-tools/verible-v0.0-4084-gf3e4d98b/bin/verible-verilog-ls"
		-- Actual ruta local, remplazar según cambie path
		-- return { "/home/" .. user .. "/miniconda3/envs/digital/bin/verible-verilog-ls" } -- cuando usaba conda
	end
end
-- Cliente para archivos .v (Verilog puro)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "verilog",
	callback = function()
		vim.lsp.start({
			name = "verible-verilog",
			cmd = {
				get_verible_bin(),
				-- añade aquí las reglas que quieras desactivar para .v
				"--rules=-unpacked-dimensions-range-ordering,-always-comb",
				-- "--rules=-always-comb",
				-- "--rules=-explicit-parameter-storage-type",
			},
			root_dir = vim.fn.getcwd(),
		})
	end,
})

-- Cliente para archivos .sv (SystemVerilog)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "systemverilog",
	callback = function()
		vim.lsp.start({
			name = "verible-systemverilog",
			cmd = {
				get_verible_bin(),
				-- aquí puedes dejar las reglas por defecto o activar otras
			},
			root_dir = vim.fn.getcwd(),
		})
	end,
})
-- #####################################################
-- END VERIBLE CONFIG TO VERILOG AND SYSTEMVERILOG FILES
-- #####################################################
