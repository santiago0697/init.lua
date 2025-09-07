-- Leader keys
vim.g.mapleader = " " -- Set <Leader> key to Space
vim.g.maplocalleader = " " -- Set <LocalLeader> key to Space

-- Fonts and clipboard
vim.g.have_nerd_font = true -- Set to true if you use a Nerd Font
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all operations

-- Line numbers
vim.opt.number = true -- Show absolute line number
vim.opt.relativenumber = true -- Show relative line numbers

-- UI behavior
vim.opt.showmode = false -- Don't show mode like -- INSERT --
-- vim.opt.signcolumn = 'yes'                    -- Always show signcolumn to avoid text shifting
-- vim.opt.cursorline = true                     -- Highlight the current line
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor when scrolling
vim.opt.list = false -- Don't show invisible characters (override if needed)
vim.opt.listchars = { -- Set how invisible characters look (used when `list = true`)
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}
vim.o.winborder = "rounded" -- Add rounded borders to floating windows

-- Editing behavior
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Autoindent new lines based on syntax
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for each indent level
vim.opt.wrap = true -- Enable visual wrapping
vim.opt.breakindent = true -- Preserve indent on wrapped lines
vim.opt.showbreak = "↳  " -- Show continuation symbol for wrapped lines

-- Search behavior
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if search contains capital letters
vim.opt.inccommand = "split" -- Show live preview of :s substitutions

-- Undo and backups
vim.opt.undofile = true -- Enable persistent undo history

-- Performance
vim.opt.updatetime = 250 -- Faster completion and diagnostics (default is 4000ms)
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (default is 1000ms)

-- Split behavior
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below

-- Misc
vim.opt.swapfile = false -- Disable swap files
