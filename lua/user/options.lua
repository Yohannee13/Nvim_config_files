local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- Indentation: use 4 spaces, no hard tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search behavior
opt.ignorecase = true
opt.smartcase = true

-- Visual comfort
opt.wrap = false
opt.scrolloff = 8
opt.termguicolors = true


opt.signcolumn = "yes"
opt.updatetime = 250
opt.cursorline = true
opt.undofile = true
