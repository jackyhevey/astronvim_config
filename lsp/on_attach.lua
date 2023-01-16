return function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        local is_available, inlayhints = pcall(require, "lsp-inlayhints")
        if is_available then
            inlayhints.on_attach(client, bufnr, false)
            vim.keymap.set("n", "<leader>uH", function()
                inlayhints.toggle()
            end, { desc = "Toggle inlay hints" })
            vim.cmd("hi! link LspInlayHint Comment")
        end
    end

    if client.server_capabilities.documentRangeFormattingProvider then
        local lsp_format_modifications_ok, lsp_format_modifications = pcall(require, "lsp-format-modifications")
        if lsp_format_modifications_ok then
            lsp_format_modifications.attach(client, bufnr, { format_on_save = false })
            vim.keymap.set("n", "<leader>lF", "<CMD>FormatModifications<CR>", { desc = "Format changed code" })
        end
    end

    if client.name == "ruff_lsp" then
        client.server_capabilities.hoverProvider = false
    end
end
