return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Customize golangcilint to ignore exit codes (golangci-lint exits with code 1-3 when issues are found)
		local golangcilint = require("lint").linters.golangcilint
		golangcilint.ignore_exitcode = true

		-- Configure linters by filetype (using Mason-managed tools)
		lint.linters_by_ft = {
			-- Go
			go = { "golangcilint" },

			-- JavaScript/TypeScript
			-- javascript = { "eslint_d" },
			-- typescript = { "eslint_d" },
			-- javascriptreact = { "eslint_d" },
			-- typescriptreact = { "eslint_d" },

			-- Lua
			-- lua = { "luacheck" },

			-- Shell
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },
		}

		-- Auto-lint on save and text changes
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				local linters = lint.linters_by_ft[vim.bo.filetype]
				if linters and #linters > 0 then
					lint.try_lint()
				end
			end,
		})

		-- Manual linting command
		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
			vim.notify("Linting...", vim.log.levels.INFO, { title = "nvim-lint" })
		end, { desc = "Trigger linting for current file" })

		-- Show linter status
		local function lint_status()
			local linters = lint.linters_by_ft[vim.bo.filetype] or {}
			if #linters == 0 then
				print("No linters configured for filetype: " .. vim.bo.filetype)
			else
				print("Linters for " .. vim.bo.filetype .. ": " .. table.concat(linters, ", "))
			end
		end

		vim.api.nvim_create_user_command("LintStatus", function()
			lint_status()
		end, {})
	end,
}
