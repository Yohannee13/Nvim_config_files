local keymap = vim.keymap

-- Why use LspAttach instead of setting keymaps globally?
-- These mappings only make sense when an LSP server is actually running on
-- the current buffer. By listening to the LspAttach event, Neovim ensures
-- the keymaps are only registered once a server has connected, so they
-- won't accidentally shadow your normal-mode keys in plain text files.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		local builtin = require("telescope.builtin")

		-- ─── NAVIGATION ──────────────────────────────────────────────────────

		-- Hover shows the documentation for whatever symbol is under the
		-- cursor (type signature, docstring, etc.). Pressing K a second time
		-- moves your cursor INTO the floating window so you can scroll it.
		opts.desc = "Show documentation for symbol under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)

		-- 'gd' is the most used LSP mapping: jump to where something is
		-- defined. We route it through Telescope so you get a fuzzy-searchable
		-- preview instead of a raw quickfix list.
		opts.desc = "Go to definition"
		keymap.set("n", "gd", builtin.lsp_definitions, opts)

		-- Declaration is different from definition: in C for example, the
		-- declaration is the prototype in a .h file, while the definition is
		-- the actual function body in a .c file.
		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		-- Jump to where an interface/type is actually implemented.
		-- Useful in Python for finding concrete classes behind abstractions.
		opts.desc = "Go to implementation"
		keymap.set("n", "gi", builtin.lsp_implementations, opts)

		-- Shows every place in your codebase that calls or uses this symbol.
		-- Telescope gives you a live preview of each reference as you scroll.
		opts.desc = "Show all references"
		keymap.set("n", "gr", builtin.lsp_references, opts)

		-- Like 'gd' but for the *type* of a variable rather than its value.
		-- For example, on a variable `int *ptr`, this jumps to the definition
		-- of `int` rather than where `ptr` was declared.
		opts.desc = "Go to type definition"
		keymap.set("n", "gt", builtin.lsp_type_definitions, opts)

		-- ─── EDITING & REFACTORING ────────────────────────────────────────────

		-- Rename the symbol under the cursor across ALL files in the project.
		-- The LSP handles finding every reference so nothing gets missed.
		opts.desc = "Rename symbol"
		keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)

		-- Code actions are context-aware fixes the LSP suggests: auto-imports,
		-- unused variable removal, quick fixes, etc. Works in visual mode too
		-- so you can request actions on a selected range of code.
		opts.desc = "Show code actions"
		keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)

		-- Format the current buffer using the LSP (or none-ls sources like
		-- stylua and c_formatter_42). Your <Leader>gf in none-ls.lua already
		-- does this, but having it here means it also works when you have a
		-- server active that provides its own formatter (e.g. clangd).
		opts.desc = "Format buffer (Conform)"
		keymap.set("n", "<Leader>gf", function()
			local status_ok, conform = pcall(require, "conform")
			if status_ok then
				conform.format({ async = true, lsp_fallback = true })
			else
				vim.lsp.buf.format({ async = true })
			end
		end, opts)

		-- ─── SYMBOLS & SEARCH ─────────────────────────────────────────────────

		-- Lists all symbols (functions, variables, types…) in the current file.
		-- Great for navigating large files without scrolling.
		opts.desc = "Search document symbols"
		keymap.set("n", "<Leader>ds", builtin.lsp_document_symbols, opts)

		-- Same but across the entire workspace/project. Slow on large codebases,
		-- but invaluable when you know the name but not the file.
		opts.desc = "Search workspace symbols"
		keymap.set("n", "<Leader>ws", builtin.lsp_workspace_symbols, opts)

		-- ─── DIAGNOSTICS ──────────────────────────────────────────────────────

		-- Diagnostics are the errors and warnings the LSP and your linters
		-- (flake8, mypy via none-ls) inject into your buffer as virtual text.
		-- These two let you jump between them without touching the mouse.
		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, opts)

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, opts)

		-- Opens the full diagnostic message in a floating window. Useful when
		-- the virtual text at the end of the line is truncated.
		opts.desc = "Show diagnostic details"
		keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)

		-- Shows ALL diagnostics in the current file in a Telescope picker,
		-- so you can fuzzy-search through all errors and warnings at once.
		opts.desc = "List file diagnostics"
		keymap.set("n", "<Leader>fd", builtin.diagnostics, opts)

		-- ─── SIGNATURE HELP ───────────────────────────────────────────────────

		-- While you are typing the arguments of a function call, this shows
		-- the function's signature (parameter names and types) in a float.
		-- It's mapped in insert mode so you can trigger it mid-typing.
		opts.desc = "Show signature help"
		keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
	end,
})
