return {
	{
		"https://gitlab.com/itaranto/plantuml.nvim",
		version = "*",
		config = function()
			require("plantuml").setup({
				renderer = {
					type = "image",
					options = {
						prog = "eog",
						dark_mode = false,
					},
				},
				render_on_write = true,
			})
		end,
	},
}
