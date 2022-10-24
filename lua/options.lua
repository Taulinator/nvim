local setGlobalOption = vim.api.nvim_set_option
local setWindowOption = vim.api.nvim_win_set_option
--Keep indentation on next line
setGlobalOption('autoindent', true)
--reread a file if it has been changed outside of vim
setGlobalOption('autoread', true)

--Write contents if it has been modified
setGlobalOption('autowrite', false)

--Adjust default color group
setGlobalOption('background', 'dark')

--Don't backup
setGlobalOption('backup', false)

--If buffer is not displayed, just hide it
setGlobalOption('bufhidden', 'hide')

--List buffers
setGlobalOption('buflisted', true)

--Dont indent C programs
setGlobalOption('cindent', false)

--Dont use nvims completion 
setGlobalOption('complete', '')

--Use the popupmenu with preview
setGlobalOption('completeopt', 'menu,menuone,preview,noinsert,noselect')

--highlight cursorline
setWindowOption(0, 'cursorline', true)

--Use hex to show unprintable
setGlobalOption('display','uhex')

--Use space for tabs
setGlobalOption('expandtab', true)

--When EOL is missing, append
setGlobalOption('fixendofline', true)

--Ensure file is saely written
setGlobalOption('fsync', true)

--let the cursor blink when in insert mode
setGlobalOption('guicursor', 'n-v-c-sm:block,o-r-cr:hor20,ve-i-ci:ver30-blinkon200-blinkoff150')

--keep buffer hidden
setGlobalOption('hidden', true)

--search while typing and hihglight
setGlobalOption('incsearch', true)

--dont have a default :make program, set per filetype in init.vim
setGlobalOption('makeprg', '')

--default Characters that form pairs
setGlobalOption('matchpairs', '(:),{:},[:],<:>')

--disable mouse support
setGlobalOption('mouse', '')

--hide mouse when typing
--setGlobalOption('mousehide', true)

--print line numbers on each line
setWindowOption(0, 'number', true)

--give popupmenu transparency
setGlobalOption('pumblend', 0)

--keep the cursor in the middle of the screen
setGlobalOption('scrolloff', 8)

--Use 4 spaces for each autoindent
setGlobalOption('shiftwidth', 4)

--Dont show intro message, dont give completion messages
setGlobalOption('shortmess', 'Ic')

--Use 4spaces for tab
setGlobalOption('tabstop', 4)

--Dont put messages on the last line needed for lightline
setGlobalOption('showmode', false)

--always show tabline
setGlobalOption('showtabline', 2)

--Dont use auto indenting
setGlobalOption('smartindent', false)

--Dont use smart tabs
setGlobalOption('smarttab', false)

--Dont save swapfiles
setGlobalOption('swapfile', false)

--Automatically use appropriate syntax highlighting
setGlobalOption('syntax', 'OFF')

--Enable 24-bitRGB
setGlobalOption('termguicolors', true)

--Enable undofile 
setGlobalOption('undofile', true)

--Dont show cmd unless used
setGlobalOption('cmdheight', 0)

--use the filetype plugin to detect languages
vim.api.nvim_command('filetype on')
