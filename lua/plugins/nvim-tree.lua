local function config()
    local ok, nvim_tree = pcall(require, 'nvim-tree')
    if not ok then
        return
    end

    nvim_tree.setup({
      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      view = {
        adaptive_size = true,
      },
      renderer = {
        add_trailing = true,
        group_empty = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
    })
    local keymap
    ok, keymap = pcall(require, 'keymap')
    if ok then
        keymap.filebrowser()
    end

end

local M = {}
function M.setup(registerPlugin)
    registerPlugin({'kyazdani42/nvim-tree.lua'})
    registerPlugin({'kyazdani42/nvim-web-devicons'})
    registerPlugin.callbackConfig(config)
end
return M
