local opts = {
  tabstop = 4,
  shiftwidth = 2,
  softtabstop = -1,
  shiftround = true,
  expandtab = true,
  smartindent = true,
  number = true,
  relativenumber = true,
  mouse = 'a',
  showmode = false,
  breakindent = true,
  undofile = true,
  ignorecase = true,
  smartcase = true,
  signcolumn = 'yes',
  updatetime = 250,
  timeoutlen = 300,
  splitright = true,
  splitbelow = true,
  list = true,
  listchars = { tab = '» ', trail = '·', lead = '·', nbsp = '␣' },
  inccommand = 'split',
  cursorline = true,
  scrolloff = 20,
  confirm = true,
}
-- set each opt
for k, v in pairs(opts) do
  vim.opt[k] = v
end
--  For more options, you can see `:help option-list`

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
