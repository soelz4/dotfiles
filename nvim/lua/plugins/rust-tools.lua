return {
	{
		"simrat39/rust-tools.nvim",
		opts = {},
		config = function()
			require("rust-tools").setup()
		end,
	},
}
