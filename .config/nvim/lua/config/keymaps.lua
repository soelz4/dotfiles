-- Commands
vim.keymap.set("n", "<C-s>", ":w<CR>", {})

-- Nvim-Neo-Tree
vim.keymap.set("n", "<C-n>", ":Neotree source=filesystem reveal=true position=left<CR>", {})

-- Global Mappings for Lsp-Config
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Buffer Local Mappings for Lsp-Config
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {})
vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, {})
vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, {})
vim.keymap.set("n", "<space>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, {})
vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, {})
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<space>f", function()
	vim.lsp.buf.format({ async = true })
end, {})

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- none-ls
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- Navigate Vim Panes Better (TMUX)
vim.keymap.set("n", "<c-k>", ": wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ": wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ": wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ": wincmd l<CR>")
vim.keymap.set("n", "<c-Up>", ": wincmd k<CR>")
vim.keymap.set("n", "<c-Down>", ": wincmd j<CR>")
vim.keymap.set("n", "<c-Left>", ": wincmd h<CR>")
vim.keymap.set("n", "<c-Right>", ": wincmd l<CR>")
