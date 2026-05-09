---@type LazySpec
return {
  {
    "polarmutex/git-worktree.nvim",
    version = "^2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local hooks = require("git-worktree.hooks")

      hooks.register(hooks.type.SWITCH, function(path, prev_path)
        vim.notify("Switched from " .. prev_path .. " to " .. path)
        hooks.builtins.update_current_buffer_on_switch(path, prev_path)
      end)

      hooks.register(hooks.type.DELETE, function()
        vim.cmd(require("git-worktree.config").update_on_change_command)
      end)

      require("telescope").load_extension("git_worktree")
    end,
    keys = {
      {
        "<leader>gw",
        function() require("telescope").extensions.git_worktree.git_worktree() end,
        desc = "Git worktrees (switch/delete)",
      },
      {
        "<leader>gW",
        function() require("telescope").extensions.git_worktree.create_git_worktree() end,
        desc = "Create git worktree",
      },
    },
  },
}
