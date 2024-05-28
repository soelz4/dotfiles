return {
	{
		"tpope/vim-surround",
		"tpope/vim-repeat",
	},
	{
		"ggandor/leap.nvim",
		config = function()
			local leap = require("leap")
			leap.add_default_mappings()
			leap.opts.case_sensetive = true
			leap.opts.safe_labels = {}
		end,
	},
}
