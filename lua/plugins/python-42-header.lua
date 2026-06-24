return {
	"Diogo-ss/42-header.nvim",
	cmd = { "Stdheader" },
    ft = "python",
	keys = { "<F1>" },
	opts = {
        length = 79,
		default_map = true, -- Default mapping <F1> in normal mode.
		auto_update = true, -- Update header when saving.
		user = vim.g.user42, -- Your user.
		mail = vim.g.mail42 -- Your mail.
		-- add other options.
	},
	config = function(_, opts)
		require("42header").setup(opts)
	end,
}
