return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<c-t>', ':ToggleTerm direction=float<cr>', desc = 'Terminal' },
    },
    opts = {--[[ things you want to change go here]]
      shell = '/bin/bash',
    },
  },
}
