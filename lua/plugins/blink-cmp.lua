return {
	"saghen/blink.cmp",
	dependencies = {
		"L3MON4D3/LuaSnip", -- back in
		"rafamadriz/friendly-snippets",
	},
	version = "v0.*",
	opts = {
		snippets = { preset = "luasnip" }, -- back to luasnip
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				buffer = {
					opts = { max_buf_size = 100000 },
				},
			},
		},
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			ghost_text = { enabled = true },
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
	},
	config = function(_, opts)
		local blink = require("blink.cmp")
		blink.setup(opts)
		-- correct Neovim 0.11+ API: applies capabilities to all LSP servers
		vim.lsp.config("*", {
			capabilities = blink.get_lsp_capabilities(),
		})
	end,
}
