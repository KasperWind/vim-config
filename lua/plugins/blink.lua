return {
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                -- optionally disable cmdline completions
                -- cmdline = {},
            },

            -- experimental signature help support
            signature = { enabled = true },
            completion = {
                documentation = {
                    auto_show = true,
                },
                menu = {
                    draw = {
                        -- columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
                        columns = { { 'kind_icon' }, { 'label' } },
                    },

                },

            }
        },
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" }
    },
}
