return {
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    cmd = {
      "JavaBuildBuildWorkspace",
      "JavaBuildCleanWorkspace",
      "JavaRunnerRunMain",
      "JavaRunnerStopMain",
      "JavaRunnerToggleLogs",
      "JavaDapConfig",
      "JavaTestRunCurrentClass",
      "JavaTestDebugCurrentClass",
      "JavaTestRunCurrentMethod",
      "JavaTestDebugCurrentMethod",
      "JavaTestViewLastReport",
      "JavaProfile",
      "JavaRefactorExtractVariable",
      "JavaRefactorExtractVariableAllOccurrence",
      "JavaRefactorExtractConstant",
      "JavaRefactorExtractMethod",
      "JavaRefactorExtractField",
      "JavaSettingsChangeRuntime",
    },
    keys = {
      { "<localleader>j", "", desc = "+Java", ft = "java" },

      { "<localleader>jb", "", desc = "+Build", ft = "java" },
      { "<localleader>jbb", "<cmd>JavaBuildBuildWorkspace<cr>", desc = "Build workspace", ft = "java" },
      { "<localleader>jbc", "<cmd>JavaBuildCleanWorkspace<cr>", desc = "Clean workspace", ft = "java" },

      { "<localleader>je", "", desc = "+Runner", ft = "java" },
      { "<localleader>jer", "<cmd>JavaRunnerRunMain<cr>", desc = "Run main", ft = "java" },
      { "<localleader>jes", "<cmd>JavaRunnerStopMain<cr>", desc = "Stop main", ft = "java" },
      { "<localleader>jel", "<cmd>JavaRunnerToggleLogs<cr>", desc = "Toggle logs", ft = "java" },

      { "<localleader>jd", "<cmd>JavaDapConfig<cr>", desc = "Dap config", ft = "java" },

      { "<localleader>jt", "", desc = "+Tests", ft = "java" },
      { "<localleader>jtc", "<cmd>JavaTestRunCurrentClass<cr>", desc = "Run current class", ft = "java" },
      { "<localleader>jtC", "<cmd>JavaTestDebugCurrentClass<cr>", desc = "Debug current class", ft = "java" },
      { "<localleader>jtm", "<cmd>JavaTestRunCurrentMethod<cr>", desc = "Run current method", ft = "java" },
      { "<localleader>jtM", "<cmd>JavaTestDebugCurrentMethod<cr>", desc = "Debug current method", ft = "java" },
      { "<localleader>jtr", "<cmd>JavaTestViewLastReport<cr>", desc = "View last report", ft = "java" },

      { "<localleader>jp", "<cmd>JavaProfile<cr>", desc = "Profile", ft = "java" },

      { "<localleader>jr", "", desc = "+Refactor", ft = "java" },
      { "<localleader>jrv", "<cmd>JavaRefactorExtractVariable<cr>", desc = "Extract variable", ft = "java" },
      {
        "<localleader>jrV",
        "<cmd>JavaRefactorExtractVariableAllOccurrence<cr>",
        desc = "Extract variable all",
        ft = "java",
      },
      { "<localleader>jrc", "<cmd>JavaRefactorExtractConstant<cr>", desc = "Extract constant", ft = "java" },
      { "<localleader>jrm", "<cmd>JavaRefactorExtractMethod<cr>", desc = "Extract method", ft = "java" },
      { "<localleader>jrf", "<cmd>JavaRefactorExtractField<cr>", desc = "Extract field", ft = "java" },

      { "<localleader>jc", "<cmd>JavaSettingsChangeRuntime<cr>", desc = "Change runtime", ft = "java" },
    },
    opts = {
      spring_boot_tools = { enable = false },
      jdk = {
        auto_install = true,
      },
    },
  },
}
