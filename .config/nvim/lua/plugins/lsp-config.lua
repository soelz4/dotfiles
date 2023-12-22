return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer" }
			})
		end
	},
	{
		-- Additional lua configuration, makes nvim stuff amazing!
		-- https://github.com/folke/neodev.nvim
		{'folke/neodev.nvim' },
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Setup language servers.
			local lspconfig = require('lspconfig')
			lspconfig.lua_ls.setup({})
			lspconfig.rust_analyzer.setup({})
		end
	}
}
