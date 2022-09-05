local function config()
    local ok, telescope = pcall(require, 'telescope')
    if not ok then
        return
    end

    telescope.setup{
        defaults = {
            mappings = {
                i = {
                    ["<TAB>"] = require('telescope.actions').move_selection_next,
                },
                n = {
                    ["<leader>f"] = require('telescope.actions').close,
                },
            },
        }
    }
end

local M = {}
function M.setup(registerPlugin)
    registerPlugin({'nvim-lua/popup.nvim'})
    registerPlugin({'nvim-lua/plenary.nvim'})
    registerPlugin({'nvim-telescope/telescope.nvim'})
    registerPlugin.callbackConfig(config)
end
return M
