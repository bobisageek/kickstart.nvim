return { -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - ysiw) - add [s]urrounding [I]nner [W]ord ; [)]Paren
    -- - ds'   - [D]elete [S]urround [']quotes
    -- - cs)'  - [c]hange [s]urrounding [)] to [']
    require('mini.surround').setup {
      mappings = {
        add = 'ys', -- Add surrounding in Normal and Visual modes
        delete = 'ds',
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding (followed by one character)
        replace = 'cs', -- Replace surrounding
      },
    }

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable: duplicate-set-field
    statusline.section_location = function()
      return '%l:%-v (%p%%)'
    end
    statusline.section_mode = function()
      return string.upper(vim.call 'mode')
    end
    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
