local function config()
    local ok, sitter = pcall(require, 'nvim-treesitter.configs')
    if not ok then
        return
    end

    sitter.setup{
        ensure_installed = {"java", "dart", "latex", "javascript", "lua", "go"},
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }
end

local M = {}
function M.setup(registerPlugin)
    registerPlugin({'nvim-treesitter/nvim-treesitter'})
    registerPlugin.callbackConfig(config)
end
return M
