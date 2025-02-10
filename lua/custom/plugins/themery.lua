return {
  'zaldih/themery.nvim',
  lazy = false,
  config = function()
    require('themery').setup {
      -- add the config here
      themes = {
        {
          name = 'Day',
          colorscheme = 'tokyonight-day',
        },
        {
          name = 'Night',
          colorscheme = 'tokyonight-night',
        },
      },
    }
  end,
}
