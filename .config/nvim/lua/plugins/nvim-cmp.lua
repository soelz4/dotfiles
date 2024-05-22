return {
	{
		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",
		lazy = false,
		config = true,
	},
	{
		-- Snippet Engine & its associated nvim-cmp source
		"L3MON4D3/LuaSnip",
		lazy = false,
		dependencies = {
			-- For luasnip users
			"saadparwaiz1/cmp_luasnip",
			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		-- https://github.com/hrsh7th/nvim-cmp
		"hrsh7th/nvim-cmp",
		lazy = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local types = require("cmp.types")
			local str = require("cmp.utils.str")
			vim.opt.completeopt = "menu,menuone,noselect"
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
					["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
					["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
					["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll backward
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll forward
					["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
					["<C-e>"] = cmp.mapping.abort(), -- clear completion window
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- confirm selection
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- lsp
					{ name = "luasnip" }, -- snippets
					{ name = "buffer" }, -- text within current buffer
					{ name = "path" }, -- file system paths
				}),
				--[[
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						show_labelDetails = true, -- show labelDetails in menu. Disabled by default

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, vim_item)
							-- Get the full snippet (and only keep first line)
							local word = entry:get_insert_text()
							if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
								word = vim.lsp.util.parse_snippet(word)
							end
							word = str.oneline(word)

							-- concatenates the string
							-- local max = 50
							-- if string.len(word) >= max then
							-- 	local before = string.sub(word, 1, math.floor((max - 3) / 2))
							-- 	word = before .. "..."
							-- end

							if
								entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
								and string.sub(vim_item.abbr, -1, -1) == "~"
							then
								word = word .. "~"
							end
							vim_item.abbr = word

							return vim_item
						end,
					}),
				},
				--]]
			})
			-- Setup up vim-dadbod
			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})
		end,
	},
}
