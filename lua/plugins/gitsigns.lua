return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	opts = {
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local opts = { buffer = bufnr, silent = true }
			vim.keymap.set("n", "]h", gs.next_hunk, opts)
			vim.keymap.set("n", "[h", gs.prev_hunk, opts)
			vim.keymap.set("n", "<Leader>hs", gs.stage_hunk, opts)
			vim.keymap.set("n", "<Leader>hr", gs.reset_hunk, opts)
			vim.keymap.set("n", "<Leader>hp", gs.preview_hunk, opts)
			vim.keymap.set("n", "<Leader>hb", gs.blame_line, opts)
		end,
	},
}
