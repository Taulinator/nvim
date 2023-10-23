local api = vim.api

--[[
██   ██ ███████ ██      ██████  ███████ ██████
██   ██ ██      ██      ██   ██ ██      ██   ██
███████ █████   ██      ██████  █████   ██████
██   ██ ██      ██      ██      ██      ██   ██
██   ██ ███████ ███████ ██      ███████ ██   ██


--]]
local packages = {}
local configCallbacks = {}
local registerPlugin = {}
function registerPlugin.callbackConfig(config)
    table.insert(configCallbacks, config)
end
setmetatable(registerPlugin, { __call = function(self, package) table.insert(packages, package) end })





--[[
██████  ██      ██    ██  ██████  ██ ███    ██ ███████
██   ██ ██      ██    ██ ██       ██ ████   ██ ██
██████  ██      ██    ██ ██   ███ ██ ██ ██  ██ ███████
██      ██      ██    ██ ██    ██ ██ ██  ██ ██      ██
██      ███████  ██████   ██████  ██ ██   ████ ███████


--]]
local install_path = vim.fn.stdpath('data')..'/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    api.nvim_command('!git clone https://github.com/savq/paq-nvim '..install_path)
end
registerPlugin({'savq/paq-nvim', opt= true})

---------------SYSTEM---------------
--completion framework
require('plugins/nvim-cmp').setup(registerPlugin)
--LSP configuration
require('plugins/lsp').setup(registerPlugin)
--telescope/fzf
require('plugins/telescope').setup(registerPlugin)
--Treesitter
require('plugins/treesitter').setup(registerPlugin)
--File browser
require('plugins/nvim-tree').setup(registerPlugin)
--markdown preview
registerPlugin({'iamcco/markdown-preview.nvim', run=vim.fn['mkdp#util#install']})
--git blame inline
registerPlugin({'f-person/git-blame.nvim'})
--symbols-outline
require('plugins/symbols-outline').setup(registerPlugin)

----------------LOOK----------------
--colorscheme
require('plugins/onenord').setup(registerPlugin)
--top and bottom line
require('plugins/lualine').setup(registerPlugin)
---Profiling
registerPlugin({'dstein64/vim-startuptime'})

require('paq')(packages)
for _, config in pairs(configCallbacks) do
    config()
end





--[[
██   ██ ███████ ██    ██ ███    ███  █████  ██████
██  ██  ██       ██  ██  ████  ████ ██   ██ ██   ██
█████   █████     ████   ██ ████ ██ ███████ ██████
██  ██  ██         ██    ██  ██  ██ ██   ██ ██
██   ██ ███████    ██    ██      ██ ██   ██ ██


--]]
local keymap = require('keymap')
keymap.defaultKeymap()





--[[
 ██████  ██████  ████████ ██  ██████  ███    ██ ███████
██    ██ ██   ██    ██    ██ ██    ██ ████   ██ ██
██    ██ ██████     ██    ██ ██    ██ ██ ██  ██ ███████
██    ██ ██         ██    ██ ██    ██ ██  ██ ██      ██
 ██████  ██         ██    ██  ██████  ██   ████ ███████


--]]
require('options')
--load colorscheme
api.nvim_command('colorscheme onenord')
