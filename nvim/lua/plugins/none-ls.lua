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
	end,
}
