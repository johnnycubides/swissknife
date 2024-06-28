-- TODO: uso incompleto, de hecho no se está cargando 2024-05-04
local Path = require("plenary.path")

return {
	{
		"JMarkin/gentags.lua",
		cond = vim.fn.executable("ctags") == 1,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gentags").setup({
				{
					root_dir = vim.g.gentags_root_dir or vim.loop.cwd(),
					cache = {
						path = Path:new(vim.fn.stdpath("cache")):joinpath("tags"), -- path where generated tags store, currently required plenary Path object
					},
					async = true, -- run ctags asynchronous
					bin = "ctags",
					args = { -- extra args
						"--extras=+r+q",
						"--exclude=.git",
						"--exclude=node_modules*",
						"--exclude=.mypy*",
						"--exclude=.pytest*",
						"--exclude=.ruff*",
						"--exclude=BUILD",
						"--exclude=vendor*",
						"--exclude=*.min.*",
					},
					-- mapping ctags --languages <-> neovim filetypes
					lang_ft_map = {
						["Python"] = { "python" },
						["Lua"] = { "lua" },
						["Vim"] = { "vim" },
						["C,C++,CUDA"] = { "c", "cpp", "h", "cuda" },
						["JavaScript"] = { "javascript" },
						["Go"] = { "go" },
					},
				},
			})
		end,
		event = "VeryLazy",
	},
}
