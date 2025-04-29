return {
  {
    "nvim-java/nvim-java",
    ft = "java",
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
      { "<LOCALLEADER>j", "", desc = "+Java", ft = "java" },

      { "<LOCALLEADER>jb", "", desc = "+Build", ft = "java" },
      { "<LOCALLEADER>jbb", "<CMD>JavaBuildBuildWorkspace<CR>", desc = "Build workspace", ft = "java" },
      { "<LOCALLEADER>jbc", "<CMD>JavaBuildCleanWorkspace<CR>", desc = "Clean workspace", ft = "java" },

      { "<LOCALLEADER>je", "", desc = "+Runner", ft = "java" },
      { "<LOCALLEADER>jer", "<CMD>JavaRunnerRunMain<CR>", desc = "Run main", ft = "java" },
      { "<LOCALLEADER>jes", "<CMD>JavaRunnerStopMain<CR>", desc = "Stop main", ft = "java" },
      { "<LOCALLEADER>jel", "<CMD>JavaRunnerToggleLogs<CR>", desc = "Toggle logs", ft = "java" },

      { "<LOCALLEADER>jd", "<CMD>JavaDapConfig<CR>", desc = "Dap config", ft = "java" },

      { "<LOCALLEADER>jt", "", desc = "+Tests", ft = "java" },
      { "<LOCALLEADER>jtc", "<CMD>JavaTestRunCurrentClass<CR>", desc = "Run current class", ft = "java" },
      { "<LOCALLEADER>jtC", "<CMD>JavaTestDebugCurrentClass<CR>", desc = "Debug current class", ft = "java" },
      { "<LOCALLEADER>jtm", "<CMD>JavaTestRunCurrentMethod<CR>", desc = "Run current method", ft = "java" },
      { "<LOCALLEADER>jtM", "<CMD>JavaTestDebugCurrentMethod<CR>", desc = "Debug current method", ft = "java" },
      { "<LOCALLEADER>jtr", "<CMD>JavaTestViewLastReport<CR>", desc = "View last report", ft = "java" },

      { "<LOCALLEADER>jp", "<CMD>JavaProfile<CR>", desc = "Profile", ft = "java" },

      { "<LOCALLEADER>jr", "", desc = "+Refactor", ft = "java" },
      { "<LOCALLEADER>jrv", "<CMD>JavaRefactorExtractVariable<CR>", desc = "Extract variable", ft = "java" },
      {
        "<LOCALLEADER>jrV",
        "<CMD>JavaRefactorExtractVariableAllOccurrence<CR>",
        desc = "Extract variable all",
        ft = "java",
      },
      { "<LOCALLEADER>jrc", "<CMD>JavaRefactorExtractConstant<CR>", desc = "Extract constant", ft = "java" },
      { "<LOCALLEADER>jrm", "<CMD>JavaRefactorExtractMethod<CR>", desc = "Extract method", ft = "java" },
      { "<LOCALLEADER>jrf", "<CMD>JavaRefactorExtractField<CR>", desc = "Extract field", ft = "java" },

      { "<LOCALLEADER>jc", "<CMD>JavaSettingsChangeRuntime<CR>", desc = "Change runtime", ft = "java" },
    },
    opts = {
      spring_boot_tools = { enable = false },
      jdk = {
        auto_install = true,
      },
    },
  },
}
