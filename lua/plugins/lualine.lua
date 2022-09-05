local lspComponent = {
    function()
        local msg = ''
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
            return msg
    end,
    icon = ':',
}

local treesitterComponent = {
    function ()
        local msg = require("nvim-treesitter").statusline()
        if msg ~= nil then
            return msg
        end
        return ''
    end,
}

local diagnosticsComponent = {
      'diagnostics',
      sources = { 'nvim_diagnostic', 'nvim_lsp' },
      sections = { 'error', 'warn', 'info'},
      diagnostics_color = {
          error = 'DiagnosticError', -- Changes diagnostics' error color.
          warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
          info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
      },
      symbols = {error = ' ', warn = ' ', info = ' '},
      colored = true,           -- Displays diagnostics status in color if set to true.
      update_in_insert = false, -- Update diagnostics in insert mode.
      always_visible = false,   -- Show diagnostics even if there are none.
}


local locationComponent = {
    'location',
    icon = {''},
}


local function config()
    local ok, lualine = pcall(require, 'lualine')
    if not ok then
        return
    end

    lualine.setup {
        options = {
            icons_enabled = true,
            theme = 'onenord',
            component_separators = { left = '', right = ''},
            section_separators = { left = '▓▒░', right = '░▒▓'},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = true,
        },
        sections = {
            lualine_a = {diagnosticsComponent},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {'branch', 'diff'},
            lualine_z = {locationComponent, 'filetype', 'encoding', 'fileformat'},
            lualine_y = {lspComponent},
        },
        inactive_sections = {
            lualine_a = {'filename'},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {locationComponent}
        },
        tabline = {
            lualine_a = {'buffers'},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {treesitterComponent}
        },
        extensions = {}
    }
end

local M = {}
function M.setup(registerPlugin)
    registerPlugin({'nvim-lualine/lualine.nvim'})
    registerPlugin.callbackConfig(config)
end

return M
