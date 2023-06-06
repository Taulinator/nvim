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

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    lsp.lua_ls.setup {
        cmd = {"lua-language-server"},
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

    lsp.bashls.setup{
        cmd = {"bash-language-server", "start"},
        capabilities = capabilities
    }

    lsp.gopls.setup{
        cmd = {"gopls", "serve"},
        settings = {
            gopls = {
                allowImplicitNetworkAccess = true
            }
        },
        capabilities = capabilities
    }

    lsp.pylsp.setup{
        cmd = {"pylsp"},
        settings = {
            plugins = {
                jedi_completion = {
                    include_class_objects = true,
                    include_function_objects = true,
                    eager = true
                }
            }
        },
        capabilities = capabilities
    }

    lsp.texlab.setup{
        cmd = {"texlab"},
        settings = {
            texlab = {
                auxDirectory = ".",
                bibtexFormatter = "texlab",
                build = {
                    args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                        executable = "latexmk",
                        forwardSearchAfter = false,
                        onSave = true
                },
                chktex = {
                    onEdit = true,
                    onOpenAndSave = false
                },
                diagnosticsDelay = 300,
                formatterLineLength = 80,
                forwardSearch = {
                    args = {}
                },
                latexFormatter = "latexindent",
                latexindent = {
                    modifyLineBreaks = false
                }
            }
        },
        capabilities = capabilities
    }

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = require('keymap').lsp
    })

end

local M = {}
function M.setup(registerPlugin)
    registerPlugin({'neovim/nvim-lspconfig'})
    registerPlugin.callbackConfig(config)
end
return M
