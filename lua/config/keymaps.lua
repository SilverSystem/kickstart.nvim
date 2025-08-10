-- This file contains custom key mappings for Neovim.

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Screen Keys
vim.keymap.set({ 'n' }, '<leader>uk', '<cmd>Screenkey<CR>')

-- Normal, Visual, Select modes
local modes_nv = { 'n', 'v', 'x' }
vim.keymap.set(modes_nv, 'j', 'h', { noremap = true, silent = true })
vim.keymap.set(modes_nv, 'k', 'k', { noremap = true, silent = true })
vim.keymap.set(modes_nv, 'l', 'j', { noremap = true, silent = true })
vim.keymap.set(modes_nv, ';', 'l', { noremap = true, silent = true })

-- Insert mode (movement with <C-o> to switch briefly to normal mode)
vim.keymap.set('i', '<C-j>', '<Left>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', '<Down>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-;>', '<Right>', { noremap = true, silent = true })

-- Command-line mode
vim.keymap.set('c', '<C-j>', '<Left>', { noremap = true, silent = true })
vim.keymap.set('c', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.keymap.set('c', '<C-l>', '<Down>', { noremap = true, silent = true })
vim.keymap.set('c', '<C-;>', '<Right>', { noremap = true, silent = true })

-- Terminal mode (requires <C-\\><C-n> to switch to normal mode first)
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><Left>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><Up>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><Down>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-;>', '<C-\\><C-n><Right>', { noremap = true, silent = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-;>', '<C-w><C-;>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

----- OIL -----
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Delete all buffers but the current one
vim.keymap.set('n', '<leader>bq', '<Esc>:%bdelete|edit #|normal`"<Return>', { desc = 'Delete other buffers but the current one' })

-- Redefine Ctrl+s to save with the custom function
vim.api.nvim_set_keymap('n', '<C-s>', ':lua SaveFile()<CR>', { noremap = true, silent = true })

-- Custom save function
function SaveFile()
  -- Check if a buffer with a file is open
  if vim.fn.empty(vim.fn.expand '%:t') == 1 then
    vim.notify('No file to save', vim.log.levels.WARN)
    return
  end

  local filename = vim.fn.expand '%:t' -- Get only the filename
  local success, err = pcall(function()
    vim.cmd 'silent! write' -- Try to save the file without showing the default message
  end)

  if success then
    vim.notify(filename .. ' Saved!') -- Show only the custom message if successful
  else
    vim.notify('Error: ' .. err, vim.log.levels.ERROR) -- Show the error message if it fails
  end
end