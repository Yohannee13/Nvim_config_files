return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black.with({
					extra_args = { "--line-length", "79" },
				}),
				null_ls.builtins.diagnostics.mypy.with({
                    extra_args = { "--strict", },
                }),
				require("none-ls.diagnostics.flake8").with({
                    extra_args = { "--max-line-length", "79" },
                }),
			},
		})
	end,
}
