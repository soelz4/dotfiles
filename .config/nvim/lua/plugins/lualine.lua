return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			-- globalstatus = false,
			theme = "molokai",
		},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}
