return function()
    require("telescope").load_extension("refactoring")
    vim.api.nvim_create_user_command("Refactoring", function()
        require("refactoring").select_refactor()
    end, {})
end
