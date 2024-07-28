-- Este repositorio requiere la instalación de git-lts (apt para debian)
return {
	{
		"https://gitlab.com/itaranto/plantuml.nvim",
		-- "https://gitlab.com/johnnycubides/plantuml.nvim.git",
		-- branch = "master",
		version = "*",
		config = function()
			require("plantuml").setup({
				renderer = {
					type = "image",
					options = {
						prog = "eog",
						dark_mode = true,
						format = "svg",
					},
				},
				render_on_write = true,
			})
		end,
	},
}
