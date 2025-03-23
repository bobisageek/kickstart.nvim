-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = true,
    keywords = {
      NOTE = { color = 'hint', alt = { 'INFO', 'SECTION' } },
      REGION = { icon = '§', color = '#FFFFFF' },
    },
    merge_keywords = true,
    highlight = { keyword = 'bg' },
  },
}
