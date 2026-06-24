vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    pattern = { "*.py" },
    callback = function()
        vim.api.nvim_buf_set_lines(0, 0, -1, false, { "#!/usr/bin/env python3" })
        vim.schedule(function()
            vim.cmd("Stdheader")
        end)
    end,
})
