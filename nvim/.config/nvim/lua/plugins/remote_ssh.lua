return {
  {
    "nosduco/remote-sshfs.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      require("telescope").load_extension("remote-sshfs")
    end,
  },
}
