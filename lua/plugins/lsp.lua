local function getContainerCmd(arguments)
    local image = arguments.image
    local volume = arguments.volume
    local mounts = arguments.mounts
    local exec = arguments.exec

    local cmd = { 'podman', 'run', '--rm', '-i'}
    if volume then
        table.insert(cmd, '-v')
        table.insert(cmd, volume .. ':/home/lsp')
    end
    if mounts then
      for i, mount in ipairs(mounts) do
        table.insert(cmd, '-v')
        table.insert(cmd, mount .. ':' .. mount)
      end
    end
    table.insert(cmd, image)
    if exec then
      for i, params in ipairs(exec) do
        table.insert(cmd, params)
      end
    end
    return cmd
end

local function disableProcessIdDetection(params)
    params.processId = vim.NIL
end


local function config()
    local ok, lsp = pcall(require, 'lspconfig')
    if not ok then
        return
    end
    local ok, util = pcall(require, 'lspconfig/util')
    if not ok then
        return
    end

    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    lsp.gopls.setup{
        cmd = getContainerCmd( {image = 'gopls', mounts = { vim.fn.getcwd() }} ),
        settings = {
            gopls = {
                allowImplicitNetworkAccess = true
            }
        },
        capabilities = capabilities
    }

    lsp.clangd.setup{
        cmd = getContainerCmd( {image = 'clangd'} ),
        capabilities = capabilities
    }

    lsp.bashls.setup{
        before_init = disableProcessIdDetection,
        cmd = getContainerCmd({ image = 'bashls', volume = 'bashls' }),
        capabilities = capabilities
    }

    lsp.yamlls.setup{
        before_init = disableProcessIdDetection,
        cmd = getContainerCmd({ image = 'yamlls' }),
        capabilities = capabilities
    }

    lsp.jdtls.setup{
        before_init = disableProcessIdDetection,
        cmd = getContainerCmd({ image= 'jdtls' , mounts = { vim.fn.getcwd() } }),
        capabilities = capabilities
    }

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    lsp.sumneko_lua.setup {
      cmd = getContainerCmd({
          image = 'sumneko_lua',
          mounts = {vim.fn.expand('~/.config/nvim')}
      }),
        settings = {
           Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
        capabilities = capabilities
    }

    vim.api.nvim_exec([[
        augroup INITRC
        autocmd!
        autocmd FileType java,cpp,python,c,sh,lua,go :lua require('keymap').lsp()
        augroup END
    ]], false)
end

local M = {}
function M.setup(registerPlugin)
    registerPlugin({'neovim/nvim-lspconfig'})
    registerPlugin.callbackConfig(config)
end
return M
