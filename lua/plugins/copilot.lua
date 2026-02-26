return (require('machine-specific').copilot or {}).enabled == true and {
  'github/copilot.vim',
} or {}
