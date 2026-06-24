return {
	"mfussenegger/nvim-lint",
	event = { "BufWritePost", "BufReadPost" },
	config = function()
		require("lint").linters.mypy.args = {
			"--strict",
		}
		require("lint").linters.flake8.args = {
			"--max-line-length=79",
			"--stdin-display-name",
			vim.api.nvim_buf_get_name(0),
			"-",
		}
		require("lint").linters_by_ft = {
			python = { "flake8", "mypy" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
