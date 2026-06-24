return {
	"saghen/blink.cmp",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	version = "v0.*",
	opts = {
		snippets = { preset = "luasnip" },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		keymap = { preset = "default" },
	},
	config = function(_, opts)
		local blink = require("blink.cmp")
		blink.setup(opts)

		vim.lsp.config("*", {
			capabilities = blink.get_lsp_capabilities(),
		})
	end,
}
