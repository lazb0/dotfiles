return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
            sources = {
                null_ls.builtins.completion.luasnip,

                -- lua
                null_ls.builtins.formatting.stylua,

                -- python
                null_ls.builtins.formatting.black,

                -- javascript, javascriptreact, typescript, typescriptreact, vue,
                -- css, scss, less, html, json, yaml, markdown, graphql
                null_ls.builtins.formatting.prettier,

                -- C, C++, CS, Java
                null_ls.builtins.formatting.clang_format,

                -- rust
                require("none-ls.formatting.rustfmt"),

                -- go
                null_ls.builtins.formatting.gofmt,
            },

            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })
        -- Custom function to run specific formatter
        function RunSpecificFormatter(formatter_name)
            local formatter = null_ls.builtins.formatting[formatter_name]
            if not formatter then
                vim.notify("Formatter not found: " .. formatter_name, vim.log.levels.ERROR)
                return
            end

            -- Attach and format
            null_ls.register({ formatter })
            vim.lsp.buf.format({
                name = "null-ls",
                async = false,
            })
        end

        -- Create user command
        vim.api.nvim_create_user_command("Format", function(opts)
            RunSpecificFormatter(opts.args)
        end, {
            nargs = 1,
            complete = function()
                local formatters = vim.tbl_keys(null_ls.builtins.formatting)
                return formatters
            end,
        })
    end,
}
