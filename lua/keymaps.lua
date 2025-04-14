-- we'll use this table in which-key later
-- to document the keymap 'paths'
-- it's here as a TOC for guidance on assigning new keymaps
local chain_paths = {
  { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
  { '<leader>d', group = '[D]ocument' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>w', group = '[W]indows' },
  { '<leader>t', group = '[T]' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  { '<leader>l', group = '[L]ocations' },
  { '<leader>f', group = '[F]iles', icon = '' },
  { '<leader>p', group = '[P]lugins' },
}

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
kmapl('k', '<cmd>WhichKey<CR>')
-- visual selection as lua
kmapl('cl', function()
  vim.cmd "'<,'>lua"
end, 'Execute selection as vim[l]ua', 'v')
-- all locations found by todo-comments
kmapl('lt', function()
  vim.cmd 'TodoLocList'
end, 'From [t]odo-comments')
-- region locations
kmapl('lr', function()
  vim.cmd 'TodoLocList keywords=REGION'
end, '[r]egion comments')
kmapl('fx', function()
  vim.cmd 'Ex'
end, 'E[x]plorer')
kmapl('pl', function()
  vim.cmd 'Lazy'
end, '[L]azy')

-- Diagnostic keymaps
kmapl('q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')
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

return {
  groupings = chain_paths,
}
