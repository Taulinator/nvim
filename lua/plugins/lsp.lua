local function disableProcessIdDetection(params)
    params.processId = vim.NIL
end
local function findRootPath(files)
    return vim.fs.dirname(vim.fs.find(files)[1])
end
local lsp = vim.api.nvim_create_augroup("LSP", { clear = true })

local M = {}

function M.sh()
    vim.api.nvim_create_autocmd("FileType",{
    group = lsp,
    pattern = "sh",
    callback = function()
        vim.lsp.start({
            name = "bashls",
            cmd = {"bash-language-server", "start"},
            root_dir = findRootPath({ ".git" }),
            settings = {
                bashIde = {
                    globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
                }
            }
        })
    end })
end
function M.dockerfile()
    vim.api.nvim_create_autocmd("FileType",{
    group = lsp,
    pattern = "dockerfile",
    callback = function()
    vim.lsp.start({
            name = "dockerls",
            cmd = { "docker-langserver", "--stdio" },
            root_dir = findRootPath({ "Dockerfile" }),
        })
    end })
end
function M.go()
    vim.api.nvim_create_autocmd("FileType",{
    group = lsp,
    pattern = { "go", "gomod", "gowork", "gotmpl" },
    callback = function()
        vim.lsp.start({
            name = "gopls",
            cmd = { "gopls", "serve" },
            root_dir = findRootPath({ "go.work", "go.mod", ".git" }),
            settings = {
                gopls = {
                    allowImplicitNetworkAccess = true
                }
            }
        })
    end })
end
function M.python()
    vim.api.nvim_create_autocmd("FileType",{
    group = lsp,
    pattern = "python",
    callback = function()
        vim.lsp.start({
            name = "pylsp",
            cmd = { "pylsp" },
            root_dir = findRootPath({ "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" }),
            settings = {
                plugins = {
                    jedi_completion = {
                        include_class_objects = true,
                        include_function_objects = true,
                        eager = true
                    }
                }
            },
        })
    end })
end
function M.latex()
    vim.api.nvim_create_autocmd("FileType",{
    group = lsp,
    pattern = { "tex", "plaintex", "bib" },
    callback = function()
        vim.lsp.start({
            name = "texlab",
            cmd = { "texlab" },
            root_dir = findRootPath({ ".latexmkrc", ".git" }),
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
            }
        })
    end})
end
function M.lua()
    vim.api.nvim_create_autocmd("FileType",{
    group = lsp,
    pattern = "lua",
    callback = function()
        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")
        vim.lsp.start({
            name = 'lua',
            cmd = {"lua-language-server"},
            root_dir = findRootPath({ ".luarc.json", ".luacheckrc", "stylua.toml", ".git" }),
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
            }
        })
    end })
end

function M.config()
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = require('keymap').lsp
    })
end
return M
