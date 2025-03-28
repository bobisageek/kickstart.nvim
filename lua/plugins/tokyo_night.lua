return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      style = 'night',
      transparent = true,
      styles = {
        comments = { italic = false }, -- Disable italics in comments
      },
      on_highlights = function(hl, cs)
        local dark_red = '#330303'
        local dark_yellow = '#242201'
        local dark_blue = '#012324'
        hl.CursorLine = { bg = dark_blue }
      end,
    }
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}

-- Visual     283457
-- CursorLine 292e42
