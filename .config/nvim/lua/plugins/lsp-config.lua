return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSP
					"lua_ls",
					"rust_analyzer",
					"gopls",
					"clangd",
					"yamlls",
					"bashls",
					"pyright",
					"htmx",
					"denols",
					"html",
					"cssls",
					"docker_compose_language_service",
					"dockerls",
					-- Diagnostics, Code Actions, Linter, and more via Lua
					"stylua",
					"gofumpt",
					"goimports-reviser",
					"golines",
					"yamlfmt",
					"yamllint",
					"shfmt",
					"mypy",
					"ruff",
					"black",
					"prettier",
					"stylelint",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({})
		end,
	},
	{
		-- Additional lua configuration, makes nvim stuff amazing!
		-- https://github.com/folke/neodev.nvim
		"folke/neodev.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			-- Setup language servers.
			-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local util = require("lspconfig/util")
			local lspconfig = require("lspconfig")
			local on_attach = function(client)
				require("completion").on_attach(client)
			end
			-- Lua (lua_ls)
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			})
			-- Rust (rust_analyzer)
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
				settings = {
					["rust-analyzer"] = {
						imports = {
							granularity = {
								group = "module",
							},
							prefix = "self",
						},
						cargo = {
							buildScripts = {
								enable = true,
							},
						},
						procMacro = {
							enable = true,
						},
					},
				},
			})
			-- Go (gopls)
			lspconfig.gopls.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
					},
				},
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			})
			-- YAML
			lspconfig.yamlls.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			})
			-- Shell
			-- Please Install shellcheck Package for Linting
			lspconfig.bashls.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
				vim.api.nvim_create_autocmd("FileType", {
					pattern = "sh",
					callback = function()
						vim.lsp.start({
							name = "bash-language-server",
							cmd = { "bash-language-server", "start" },
						})
					end,
				}),
			})
			-- Python (pyright)
			lspconfig.pyright.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
				filetypes = { "python" },
			})
			-- Docker and Docker-Compose
			lspconfig.docker_compose_language_service.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			})
			lspconfig.dockerls.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			})
			-- HTMX
			lspconfig.htmx.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			})
			-- HTML
			lspconfig.html.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			})
			-- CSS
			lspconfig.cssls.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			})
			-- Deno
			-- Please Install Deno - curl -fsSL https://deno.land/install.sh | sh
			-- Use deno init for Each Project (LSP, Linting, Formatting)
			lspconfig.denols.setup({
				capabilities = capabilities,
				-- on_attach = on_attach,
			})
		end,
	},
}
