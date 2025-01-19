-- https://github.com/tjdevries/advent-of-nvim/tree/master
-- https://github.com/nvim-lua/kickstart.nvim
-- https://github.com/ThePrimeagen/init.lua/tree/master
-- https://github.com/ThePrimeagen/.dotfiles/blob/master/tmux/.tmux.conf
-- https://github.com/taekwombo/habitat/tree/master/config/nvim

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true

-- Use relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Go back to [P]roject [V]iew
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Move selected line(s) down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

-- Move selected line(s) up
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- vim.keymap.set("v", "<", "<gv", { desc = "Stay in visual mode during outdent" })
-- vim.keymap.set("v", ">", ">gv", { desc = "Stay in visual mode during indent" })

-- TODO
vim.keymap.set('n', 'J', 'mzJ`z')

-- Jump page down + center the screen
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Jump page up + center the screen
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- TODO
vim.keymap.set('n', 'n', 'nzzzv')

-- TODO
vim.keymap.set('n', 'N', 'Nzzzv')

-- TODO greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- TODO next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- TODO
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See :help lua-guide-autocommands

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Hey! Put lazy into the runtimepath for neovim!
vim.opt.runtimepath:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    { import = 'config.plugins' },
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
}
