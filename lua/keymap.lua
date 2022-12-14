local M = {}
local api = vim.api
vim.g.mapleader = ' '





function M.defaultKeymap()
    api.nvim_set_keymap('i', 'jh', '<ESC>', {noremap = true})
    api.nvim_set_keymap('i', 'hj', '<ESC>', {noremap = true})
    --switch between buffers
    api.nvim_set_keymap('n', '<leader>j', ':bprevious<CR>', { noremap = true, silent = true})
    api.nvim_set_keymap('n', '<leader>k', ':bnext<CR>', { noremap = true, silent = true})
    --remove all visible buffers, except the one the cursor is on
    api.nvim_set_keymap('n', '<C-c>', ':bd<CR>', { noremap = true, silent = true})
    --change working directory using cd
    api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<CR>', { noremap = true, silent = true})
end

function M.tabComplete()
    api.nvim_set_keymap('i', '<tab>', 'pumvisible() ? "<c-n>" : "<tab>"', {noremap = true, expr = true})
end


function M.filebrowser()
    api.nvim_set_keymap('n', '<leader>d', '<cmd>lua require("nvim-tree.api").tree.toggle()<CR>', { noremap = true, silent = true})
end


function M.telescope()
    api.nvim_set_keymap('n', '<leader>f', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap = true, silent = true})
    api.nvim_set_keymap('n', '<leader>g', '<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep>")})<CR>', {noremap = true, silent = true})
    api.nvim_set_keymap('n', '<leader>c', '<cmd>lua require("telescope.builtin").git_status()<CR>', {noremap = true, silent = true})
end

function M.lsp()
    api.nvim_buf_set_keymap(0, 'n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
    api.nvim_buf_set_keymap(0, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true, silent = true})
    --check if telescope is loaded
    if pcall(require, 'telescope') then
        api.nvim_buf_set_keymap(0, 'n', '<F5>', '<cmd>lua require("telescope.builtin").lsp_code_actions()<CR>', {noremap = true, silent = true})
    else
        api.nvim_buf_set_keymap(0, 'n', '<F5>', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})
    end
    api.nvim_buf_set_keymap(0, 'n', '<leader>l', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
    api.nvim_buf_set_keymap(0, 'n', '<leader>ll', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true, silent = true})
end

api.nvim_exec([[
    function OpenPDFReader() abort
        let l:PDFFile = expand('%:p:r') . '.pdf'
        execute "!" . "zathura --fork " . l:PDFFile
    endfunction]], false)


function M.latex()
    api.nvim_buf_set_keymap(0, 'n', '<F5>', ':call OpenPDFReader()<CR>', {noremap = true, silent = true})
end

return M
