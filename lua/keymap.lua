local M = {}
local keymap = vim.keymap
vim.g.mapleader = ' '

function M.defaultKeymap()
    keymap.set('i', 'jh', '<ESC>', {noremap = true})
    keymap.set('i', 'hj', '<ESC>', {noremap = true})
    --switch between buffers
    keymap.set('n', '<leader>j', ':bprevious<CR>', { noremap = true, silent = true})
    keymap.set('n', '<leader>k', ':bnext<CR>', { noremap = true, silent = true})
    --remove all visible buffers, except the one the cursor is on
    keymap.set('n', '<C-c>', ':bd<CR>', { noremap = true, silent = true})
    --change working directory using cd
    keymap.set('n', '<leader>cd', ':cd %:p:h<CR>', { noremap = true, silent = true})
end

function M.tabComplete()
    keymap.set('i', '<tab>', function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>" end, {noremap = true, expr = true})
end

function M.filebrowser()
    local ok, browser = pcall(require, 'nvim-tree/api')
    if not ok then
        return
    end
    keymap.set('n', '<leader>d', browser.tree.toggle, {noremap = true, silent = true})
end

function M.telescope()
    local ok, telescope = pcall(require, 'telescope/builtin')
    if not ok then
        return
    end
    local opts = {noremap = true, silent = true}
    keymap.set('n', '<leader>f', telescope.find_files, opts)
    keymap.set('n', '<leader>g', function() telescope.grep_string({ search = vim.fn.input("Grep>")}) end, opts)
    keymap.set('n', '<leader>c', telescope.git_status, opts)
end

function M.lsp(args)
    local opts = {noremap = true, silent = true, buffer = args.buf}
    keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts)
    keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
    keymap.set('n', '<F5>', vim.lsp.buf.code_action, opts)
    keymap.set('n', '<leader>l', vim.lsp.buf.hover, opts)
    keymap.set('n', '<leader>ll', vim.lsp.buf.references, opts)
end

function M.symbols_outline()
    local ok, symbols_outline = pcall(require, 'symbols-outline')
    if not ok then
        return
    end
    keymap.set('n', '<leader>o', symbols_outline.toggle_outline, {noremap = true, silent = true})
end

return M
