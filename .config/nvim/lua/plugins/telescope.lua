-- plugins/telescope.lua:
-- FZF
return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{ "nvim-telescope/telescope-file-browser.nvim" },
		},
		config = function()
			local builtin = require("telescope.builtin")
			-- Telescope Keymaps
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<space>fb", function()
				require("telescope").extensions.file_browser.file_browser()
			end)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fr", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		-- This is your opts table
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						hidden = true,
						-- theme = "dropdown",
					},
				},
				extensions = {
					file_browser = {
						theme = "ivy",
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("ui-select")
		end,
	},
}
