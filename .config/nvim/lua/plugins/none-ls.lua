return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local h = require("null-ls.helpers")
			local methods = require("null-ls.methods")
			local u = require("null-ls.utils")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.diagnostics.eslint,
					-- null_ls.builtins.completion.spell,
					-- null_ls.builtins.formatting.rustfmt,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports_reviser,
					null_ls.builtins.formatting.golines,
					null_ls.builtins.formatting.yamlfmt,
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.diagnostics.yamllint,
					null_ls.builtins.diagnostics.mypy,
					-- null_ls.builtins.diagnostics.ruff,
					null_ls.builtins.diagnostics.stylelint,
					null_ls.builtins.formatting.sql_formatter,
				},
			})
		end,
	},
}
