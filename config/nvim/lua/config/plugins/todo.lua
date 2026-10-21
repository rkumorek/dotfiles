return {
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'bngarren/checkmate.nvim',
    -- ft = 'markdown', -- Lazy loads for Markdown files matching patterns in 'files'
    opts = {
      -- your configuration here
      -- or leave empty to use defaults
    },
  },
}
