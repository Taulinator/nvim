local function disableProcessIdDetection(params)
    params.processId = vim.NIL
end
local function findRootPath(files)
    return vim.fs.dirname(vim.fs.find(files)[1])
end
local lsp = vim.api.nvim_create_augroup("LSP", { clear = true })


local function sh()
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
local function dockerfile()
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
local function go()
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
local function python()
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
local function latex()
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
local function lua()
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
local function java()
  vim.api.nvim_create_autocmd("FileType", {
    group = lsp,
    pattern = "java",
    callback = function ()
      require('jdtls').start_or_attach({
        cmd = {
          '/usr/lib/jvm/java-17-openjdk/bin/java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
          '-jar', '/opt/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
          '-configuration', '/opt/jdtls/config_linux',
          '-data', '/home/dev/project/.workspace'
        },
        root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-11",
                  path = "/usr/lib/jvm/java-11-openjdk"
                },
                {
                  name = "JavaSE-12",
                  path = "/usr/lib/jvm/java-12-openjdk"
                },
                {
                  name = "JavaSE-13",
                  path = "/usr/lib/jvm/java-13-openjdk"
                },
                {
                  name = "JavaSE-14",
                  path = "/usr/lib/jvm/java-14-openjdk"
                },
                {
                  name = "JavaSE-15",
                  path = "/usr/lib/jvm/java-15-openjdk"
                },
                {
                  name = "JavaSE-16",
                  path = "/usr/lib/jvm/java-16-openjdk"
                },
                {
                  name = "JavaSE-17",
                  path = "/usr/lib/jvm/java-17-openjdk"
                }
              }
            }
          }
        }
      })
    end
  })
end

local function config()
  sh()
  dockerfile()
  go()
  python()
  latex()
  lua()
  java()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = require('keymap').lsp
  })
end


local M = {}
function M.setup(registerPlugin)
  registerPlugin({'mfussenegger/nvim-jdtls'})
  registerPlugin.callbackConfig(config)
end
return M
