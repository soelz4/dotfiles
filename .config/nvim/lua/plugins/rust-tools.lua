return {
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local rt = require("rust-tools")
			rt.setup({})
		end,
	},
}
