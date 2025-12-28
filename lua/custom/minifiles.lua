-- #REGION: toggle dot files

local show_dotfiles = false

local filter_show = function(_)
  return true
end

local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh { content = { filter = new_filter } }
end

-- REGION: toggle show function

local minifiles_toggle = function()
  if not MiniFiles.close() then
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false, { content = {
      filter = show_dotfiles and filter_show or filter_hide,
    } })
  end
end

-- REGION: Set focused directory as current working directory
local set_cwd = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify 'Cursor is not on valid entry'
  end
  vim.fn.chdir(vim.fs.dirname(path))
end

-- REGION: open files in splits

local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local cur_target = MiniFiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. ' split')
      return vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)
    MiniFiles.go_in()
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = 'Split ' .. direction
  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

-- REGION: add keybinds to mf window

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak left-hand side of mapping to your liking
    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle Hidden' })
    vim.keymap.set('n', '!', set_cwd, { buffer = buf_id, desc = 'Set cwd' })
    map_split(buf_id, 's', 'belowright horizontal')
    map_split(buf_id, 'v', 'belowright vertical')
    map_split(buf_id, 't', 'tab')
  end,
})

-- REGION: return function for keymapping
return {
  minifiles_toggle = minifiles_toggle,
}
