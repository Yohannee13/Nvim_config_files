return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
			},
			format_on_save = { timeout_ms = 500 },
		})

		vim.keymap.set("n", "<Leader>gf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Formater le fichier" })
	end,
}
