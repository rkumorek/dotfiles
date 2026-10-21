return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      -- {
      --   'supermaven-inc/supermaven-nvim',
      --   config = function()
      --     require('supermaven-nvim').setup {}
      --   end,
      -- },
    },

    version = '1.*',

    opts = {
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono',
      },

      signature = { enabled = true },
    },
  },
}
