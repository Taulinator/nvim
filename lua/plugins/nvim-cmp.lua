local icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "⌘",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "廓",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

local function config()
    local ok, cmp = pcall(require, 'cmp')
    if not ok then
        return
    end
    local ok, snippy = pcall(require, 'snippy')
    if not ok then
        return
    end

 	cmp.setup {
        experimental = {
            native_menu = false,
            ghost_text = false,
        },
        completion = {
            keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
            keyword_length = 3,
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(_, vim_item)
                vim_item.menu = vim_item.kind
                vim_item.kind = icons[vim_item.kind]
                return vim_item
            end,
        },
        mapping = {
            ["<CR>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                        fallback()
                    end
                end,
                s = cmp.mapping.confirm({ select = true }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif snippy.can_expand_or_advance() then
                    snippy.expand_or_advance()
                else
                    fallback()
                end
            end,
            { "i", "s" })
        },
        snippet = {
            expand = function(args)
                snippy.expand_snippet(args.body)
            end
        },
        sources = {
            { name = "nvim_lsp", group_index = 1 },
            { name = "snippy", group_index = 1 },
            { name = "path", group_index = 1 },
            { name = "buffer", group_index = 2 },
        },
    }
  end

local M = {}
function M.setup(registerPlugin)
  registerPlugin({'hrsh7th/nvim-cmp'})
  registerPlugin({'hrsh7th/cmp-nvim-lsp'})
  registerPlugin({'hrsh7th/cmp-path'})
  registerPlugin({'hrsh7th/cmp-buffer'})
  registerPlugin({'dcampos/nvim-snippy'})
  registerPlugin({'dcampos/cmp-snippy'})
  registerPlugin.callbackConfig(config)
end

return M
