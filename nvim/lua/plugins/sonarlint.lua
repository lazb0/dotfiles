return {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    dependencies = {
        "mfussenegger/nvim-jdtls",
    },
    config = function()
        local pathToNodeExecutable = vim.fn.exepath("node")

        if type(pathToNodeExecutable) ~= "string" or pathToNodeExecutable == "" then
            vim.notify(
                string.format("pathToNodeExecutable '%s' is not valid", pathToNodeExecutable),
                vim.log.levels.WARN,
                {
                    stuff = pathToNodeExecutable,
                }
            )
        end

        -- SonarLint setup
        require("sonarlint").setup({
            server = {
                cmd = {
                    "/bin/java",
                    "-jar",
                    vim.fn.expand("$MASON/packages/sonarlint-language-server/extension/server/sonarlint-ls.jar"),
                    "-stdio",
                    "-analyzers",
                    vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
                    vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
                },
                --settings = {
                --    sonarlint = {
                --        pathToNodeExecutable = pathToNodeExecutable,
                --    },
                --},
            },
            filetypes = {
                "javascript",
                "typescript",
                "python",
            },
        })
    end,
}
