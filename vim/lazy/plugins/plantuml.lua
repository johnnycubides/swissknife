return {
	{
		-- "https://gitlab.com/itaranto/plantuml.nvim",
		"https://gitlab.com/johnnycubides/plantuml.nvim.git",
		branch = "master",
		version = "*",
		config = function()
			require("plantuml").setup({
				renderer = {
					type = "image",
					options = {
						prog = "eog",
						dark_mode = true,
						svg = true,
					},
				},
				render_on_write = true,
			})
		end,
	},
}
