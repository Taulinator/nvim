![Treesitter](https://user-images.githubusercontent.com/10790526/188520657-96083c3b-1685-4917-8926-eaff1179ba4c.png)

# Simple, Lean, Modular

## Simple
Each plugin has its own configuration file, configuration is done on a per-plugin-basis, lua only. No deep file hierarchies, or dependencies to other files!

## Lean
I try to keep the dependencies to a minimal, by installing mostly lightweight lua written plugins.
Only plugins I really need are installed. Some things can by done with a couple lines of code, without installing whole new plugins!
This keeps my setup blazingly fast(97.1ms vim-startup), without lazy loading anything.

## Modular
Each plugin should be complete on its own.
This is done by keeping the installation as well as configuration in its own seperate file.
Using this approach, each plugin is whole in its own configuration file, enabling a very modular way of tinkering the system.
Configurations are executed using a callback function:
```lua
function M.setup(registerPlugin)
   registerPlugin({'hrsh7th/nvim-cmp'})
   registerPlugin({'hrsh7th/cmp-nvim-lsp'})
   registerPlugin({'hrsh7th/cmp-path'})
   registerPlugin({'hrsh7th/cmp-buffer'})
   registerPlugin.callbackConfig(config)
end
```
To disable a plugin with all its configuration, you simply uncomment it:
```lua
--require('plugins/lualine').setup(registerPlugin)
```

# Setup
On the first run, paq will be installed, a simple `:PaqInstall` should do the trick.

# LSP
I put all of the LSPs into containers, reducing the need of dependencies and headaches setting them up. As of now, Java, Lua, C++, Go and Bash are working fairly well.
![Autocompletion](https://user-images.githubusercontent.com/10790526/188520785-98a601e7-3314-4467-bcd7-4de2fde6b6b9.png)

