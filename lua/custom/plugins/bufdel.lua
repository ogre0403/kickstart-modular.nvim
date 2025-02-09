return {
  {
    'ojroques/nvim-bufdel',
    config = function()
      require('bufdel').setup {
        next = 'tabs',
        quit = true, -- quit Neovim when last buffer is closed
      }
      vim.keymap.set('n', '<S-x>', '<CMD>BufDel<CR>')
      vim.keymap.set('n', '<c-x>', '<CMD>BufDelOthers<CR>')
    end,
  },
}
