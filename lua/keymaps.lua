local telescope = require 'telescope.builtin'
local mini_files = require 'custom.minifiles'

-- we'll use this table in which-key later
-- to document the keymap 'paths'
-- it's here as a TOC for guidance on assigning new keymaps
local chain_paths = {
  { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
  { '<leader>cw', group = '[W]orkspace' },
  { '<leader>d', group = '[D]ocument' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>t', group = '[T]erminal/[T]abs' },
  { '<leader>g', group = '[G]it' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  { '<leader>l', group = '[L]ocations' },
  { '<leader>f', group = '[F]iles', icon = '' },
  { '<leader>o', group = '[O]rg mode' },
  { '<leader>]', group = 'Plugins' },
  { '<leader>:', group = 'Commands' },
  { '<leader>m', group = '[M]eta (neovim-related)' },
}

-- comment the line
vim.keymap.set('n', '<leader>cc', 'gcc', { desc = 'Toggle Line Comment', remap = true })

vim.keymap.set('n', '<C-p>', function()
  vim.cmd 'startinsert'
  require('which-key').show {
    mode = 'i',
    keys = '<C-r>',
  }
  local k = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
  vim.api.nvim_feedkeys(k, 't', true)
end)

--  See `:help vim.keymap.set()`
local kmap = function(keys, func, desc, mode)
  desc = desc or ''
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { desc = desc })
end

local function kmapl(keys, func, desc, mode)
  kmap('<leader>' .. keys, func, desc, mode)
end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
kmap('<Esc>', '<cmd>nohlsearch<CR>')
-- disable the default behavior of 's'
kmap('s', '<Nop>')
-- visual block mode without <C-v> because windows
kmap('<C-b>', '<C-v>', 'visual block mode', 'v')
kmapl('k', '<cmd>WhichKey<CR>', 'which-key (all the keys)')
kmapl('w', '<C-w>')
-- visual selection as lua
kmapl('ml', ':lua<CR>', 'Execute selection as vim[l]ua', 'v')
kmapl('mf', '<cmd>w<CR><cmd>source %<CR>', 'save and source this [f]ile')
-- all locations found by todo-comments
kmapl('lt', function()
  vim.cmd 'TodoTelescope'
end, 'From [t]odo-comments')
-- region locations
kmapl('lr', function()
  vim.cmd 'TodoTelescope keywords=REGION'
end, '[r]egion comments')
kmapl('fx', function()
  vim.cmd 'Ex'
end, 'E[x]plorer')
kmapl('fm', mini_files.minifiles_toggle, '[m]ini')
kmapl(']l', function()
  vim.cmd 'Lazy'
end, '[L]azy')
kmap('sj', '<cmd>HopChar2<CR>', '[j]ump')

-- Diagnostic keymaps
kmapl('q', telescope.diagnostics, 'Open diagnostic [Q]uickfix list')
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
kmap('<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode', 't')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
kmap('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
kmap('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
kmap('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
kmap('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')
kmap('<C-left>', '<C-w><C-h>', 'Move focus to the left window')
kmap('<C-right>', '<C-w><C-l>', 'Move focus to the right window')
kmap('<C-down>', '<C-w><C-j>', 'Move focus to the lower window')
kmap('<C-up>', '<C-w><C-k>', 'Move focus to the upper window')

-- visual indents stay selected
kmap('>', '>gv', 'Indent', 'v')
kmap('<', '<gv', 'Outdent', 'v')

kmapl('y', '"+y', 'Yank to system clipboard', { 'n', 'v' })
kmapl('p', '"+p', 'Paste from system clipboard', { 'n', 'v' })

-- git stuff via telescope
kmapl('gl', telescope.git_commits, 'Git [l]og')
kmapl('gh', telescope.git_bcommits, 'Git [h]istory')
kmapl('gs', telescope.git_status, 'Git [s]tatus')

kmapl('so', telescope.vim_options, '[S]earch vim [O]ptions')
kmapl('sp', function()
  telescope.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy') }
end, '[S]earch [p]lugin files')
-- kmapl ''

-- like normal mode's '*', but search in the workspace
kmap('<A-*>', function()
  telescope.grep_string { word_match = '-w' }
end, 'find word in cwd')

-- commands
kmapl(':a', telescope.commands, '[a]ll commands')
kmapl(':h', telescope.command_history, '[h]istory')

-- shortcut for leader-t
local function kmapt(keys, func, desc, mode)
  kmap('<leader>t' .. keys, func, desc, mode)
end

-- terminal stuff
kmapt('m', function()
  vim.cmd.new()
  vim.cmd.term 'nu'
  vim.api.nvim_win_set_height(0, 10)
  vim.cmd.startinsert()
end, '[m]ini terminal window')
kmapt('t', function()
  vim.cmd.tabnew()
  vim.cmd.term 'nu'
  vim.cmd.startinsert()
end, 'terminal in new [t]ab')

-- tabs

kmapt('n', '<cmd>tabnew<CR>', 'New')
kmapt('N', function()
  vim.cmd.tabnew()
  telescope.find_files()
end, 'New w/ find')
kmapt('x', '<cmd>tabclose<CR>', 'Close')
kmapt('l', '<cmd>tabNext<CR>', 'Next')
kmapt('h', '<cmd>tabprevious<CR>', 'Next')

return {
  groupings = chain_paths,
}
