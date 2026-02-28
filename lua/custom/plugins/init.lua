-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- PLUGIN DE DASHBOARD
  {
    'nvimdev/dashboard-nvim',
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function()
      local logo = [[
                                            ░░░ ░▒▓▓▒░░░░░                                          
                                         ░ ████████████████░░                                       
                                        ████░░░░       ░░ ███░                                      
                                   ░░ ███░          ░ ░░░ ░░▓██░                                    
                                   ░███░          ░▒████████████                                    
                ██░             ░░██▓░           ██                                                     
               █░            ░▒██░            ░█░                   ░░▓███▒░░░                        
               ░▓█▓░░  ░░░░██▓                ░▒█▒░           ░▒███░░       ░░████░░ ▒███░░           
                 ░█████████░░                   ░███░     ░ ░███░░              ░▒███▒░░              
                  ░░░░░░           ░░░░░░       ░▒█████████░░░                                      
                              ░▓█████████████▓░                  ░░█████████████░░                  
             ░░░        ░░░▓████░░         ░░█████▒░ ░░░  ░░░░█████░░░          ░███░░              
             ░███▒░░░▒▓█████░░                 ░░▒████████████▒░░                  ░░               
               ░░░░▒▒▒░░░░░                          ░░░  ░                                         
                                      ░░████████▒░                                                  
                               ░░░░████▓░░░   ░░░▓█████░░░ ░░                                       
                                                    ]]

      logo = string.rep('\n', 2) .. logo .. '\n\n'

      local opts = {
        theme = 'doom',
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, '\n'),
        -- stylua: ignore
        center = 
          {
            { action = "Telescope find_files",         desc = " Find File",       icon = " ", key = "f" },
            { action = "ene | startinsert",            desc = " New File",        icon = " ", key = "n" },
            { action = "Telescope oldfiles",           desc = " Recent Files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",          desc = " Find Text",       icon = " ", key = "g" },
            { action = "edit $MYVIMRC",                desc = " Config",          icon = " ", key = "c" },
            { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras",                   desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                         desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
        button.key_format = '  %s'
      end

      -- open dashboard after closing lazy
      if vim.o.filetype == 'lazy' then
        vim.api.nvim_create_autocmd('WinClosed', {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function() vim.api.nvim_exec_autocmds('UIEnter', { group = 'dashboard' }) end)
          end,
        })
      end

      return opts
    end,
  },

  -- PLUGIN DE TMUX
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
}
