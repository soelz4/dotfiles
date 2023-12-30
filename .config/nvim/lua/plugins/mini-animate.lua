-- Animations
return {
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.cursor = {
				enable = false,
			}
			opts.scroll = {
				enable = false,
			}
		end,
	},
}
