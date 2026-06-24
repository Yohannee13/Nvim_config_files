return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pyright",
				},
			})
			vim.lsp.config("pyright", {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "off",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticSeverityOverrides = {
								reportUnusedImport = "warning",
								reportUnusedVariable = "warning",
							},
						},
					},
				},
			})
			-- New Neovim 0.11 native API.
			-- nvim-lspconfig provides the default config for each server,
			-- and vim.lsp.enable() activates them using Neovim's built-in system.
			vim.lsp.enable({ "lua_ls", "clangd", "pyright" })
		end,
	},
}
