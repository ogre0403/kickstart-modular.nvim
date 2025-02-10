return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function()
      require('bufferline').setup {
        options = {
          always_show_bufferline = true,
          numbers = function(opts)
            return string.format('%s', opts.ordinal)
          end,

          offsets = {
            {
              filetype = 'neo-tree',
              text = 'File Explorer',
              separator = true,
              text_align = 'left',
            },
          },
        },
      }

      vim.keymap.set('n', '<S-Right>', '<CMD>BufferLineCycleNext<CR>')
      vim.keymap.set('n', '<S-Left>', '<CMD>BufferLineCyclePrev<CR>')
    end,
  },
}
