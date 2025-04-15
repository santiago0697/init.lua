local o = vim.o
o.expandtab=true -- expand tab input with spaces characters
o.smartindent=true -- syntax aware indentations for newline inserts
o.tabstop=2 -- num of space characters per tab
o.shiftwidth=2 -- spaces per indentation level
o.splitbelow=true --Horizontal splits will automatically be below
o.splitright=true --Vertical splits will automatically be to the right
o.showmode=false --We don't need to see things like -- INSERT -- anymore
-- vim.o.clipboard="unnamedplus" --Copy paste between vim and everything else
-- vim.o.hidden=true --Required to keep multiple buffers open

local wo = vim.wo
wo.number=true -- show line number
wo.relativenumber=true -- show relative line number
wo.cursorline=false --Enable highlighting of the current line
-- vim.wo.wrap=false --Display long lines as just one line

-- auto-reload files when modified exernally
vim.opt.autoread = true
vim.api.nvim_create_autocmd(
{
  "BufEnter",
  "CursorHold",
  "CursorHoldI",
  "FocusGained" 
},
{
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- prevents auto-commenting new lines
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
})
