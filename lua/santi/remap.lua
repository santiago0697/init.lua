vim.g.mapleader = " "

-- split remaps
vim.keymap.set("n", "<leader>v", vim.cmd.new, {silent = true})
vim.keymap.set("n", "<leader>h", vim.cmd.vnew, {silent = true})

-- split movements
vim.keymap.set("n", "<C-h>", '<C-w>h')
vim.keymap.set("n", "<C-j>", '<C-w>j')
vim.keymap.set("n", "<C-k>", '<C-w>k')
vim.keymap.set("n", "<C-l>", '<C-w>l')

-- highlight search
vim.keymap.set("n", "<leader>.", ":set hlsearch!<CR>", {silent = true})

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

