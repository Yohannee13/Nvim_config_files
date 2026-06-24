return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		win = {
			preview = {
				position = "left",
				size = { width = 0.3 },
			},
		},
	},
	keys = {
		-- Open/Close the global diagnostic panel (Norminette/Compiler warnings)
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		-- Filter diagnostics to show errors ONLY for the file you are currently editing
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		-- View structural LSP symbols (Functions, Structs, Macros in your C file)
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		-- Quickly jump to the next/previous error in your project without opening the panel
		{
			"]q",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
				else
					local ok, _ = pcall(vim.cmd, "cnext")
					if not ok then
						pcall(vim.cmd, "cfirst")
					end
				end
			end,
			desc = "Next Trouble/Quickfix Item",
		},
		{
			"[q",
			function()
				if require("trouble").is_open() then
					require("trouble").prev({ skip_groups = true, jump = true })
				else
					local ok, _ = pcall(vim.cmd, "cprev")
					if not ok then
						pcall(vim.cmd, "clast")
					end
				end
			end,
			desc = "Prev Trouble/Quickfix Item",
		},
	},
}
