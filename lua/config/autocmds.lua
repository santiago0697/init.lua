local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- prevents auto-commenting new lines
api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function()
		vim.keymap.set("n", "gs", function()
			vim.lsp.buf.signature_help()
		end, { desc = "Signature Help" })

		vim.keymap.set("n", "<leader>cr", function()
			vim.lsp.buf.rename()
		end, { desc = "Code Rename" })

		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, { desc = "Code Action" })
	end,
})
