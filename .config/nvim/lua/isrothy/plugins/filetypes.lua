local swift = { { "keith/swift.vim", ft = { "swift" } } }
local kitty = { { "fladson/vim-kitty", ft = { "kitty" } } }

local tex = {
  "lervag/vimtex",
  keys = {
    -- Outer text objects.
    { "ac", "<plug>(vimtex-ac)", mode = { "o", "x" }, desc = "Around command", ft = "tex" },
    { "ad", "<plug>(vimtex-ad)", mode = { "o", "x" }, desc = "Around delimiter", ft = "tex" },
    { "ae", "<plug>(vimtex-ae)", mode = { "o", "x" }, desc = "Around environment", ft = "tex" },
    { "am", "<plug>(vimtex-a$)", mode = { "o", "x" }, desc = "Around math environment", ft = "tex" },
    { "ap", "<plug>(vimtex-aP)", mode = { "o", "x" }, desc = "Around Section", ft = "tex" },
    { "ax", "<plug>(vimtex-am)", mode = { "o", "x" }, desc = "Around item", ft = "tex" },

    -- Inner text objects.
    { "ic", "<plug>(vimtex-ic)", mode = { "o", "x" }, desc = "Inside command", ft = "tex" },
    { "id", "<plug>(vimtex-id)", mode = { "o", "x" }, desc = "Inside delimiter", ft = "tex" },
    { "ie", "<plug>(vimtex-ie)", mode = { "o", "x" }, desc = "Inside environment", ft = "tex" },
    { "im", "<plug>(vimtex-i$)", mode = { "o", "x" }, desc = "Inside math environment", ft = "tex" },
    { "if", "<plug>(vimtex-iP)", mode = { "o", "x" }, desc = "Inside section", ft = "tex" },
    { "ix", "<plug>(vimtex-im)", mode = { "o", "x" }, desc = "Inside item", ft = "tex" },

    -- Single/motion mappings.
    { "%", "<plug>(vimtex-%)", mode = { "n", "o" }, desc = "Find matching pair", ft = "tex" },
    { "]f", "<plug>(vimtex-]])", mode = { "n", "o" }, desc = "Next section start", ft = "tex" },
    { "]F", "<plug>(vimtex-][)", mode = { "n", "o" }, desc = "Next section end", ft = "tex" },
    { "[f", "<plug>(vimtex-[[)", mode = { "n", "o" }, desc = "Previous section start", ft = "tex" },
    { "[F", "<plug>(vimtex-[])", mode = { "n", "o" }, desc = "Previois section end", ft = "tex" },

    { "]m", "<plug>(vimtex-]m)", mode = { "n", "o" }, desc = "Next begin environment", ft = "tex" },
    { "]M", "<plug>(vimtex-]M)", mode = { "n", "o" }, desc = "Next end environment", ft = "tex" },
    { "[m", "<plug>(vimtex-[m)", mode = { "n", "o" }, desc = "Previous begin environment", ft = "tex" },
    { "[M", "<plug>(vimtex-[M)", mode = { "n", "o" }, desc = "Previous end environment", ft = "tex" },

    { "]n", "<plug>(vimtex-]n)", mode = { "n", "o" }, desc = "Next math zone start", ft = "tex" },
    { "]N", "<plug>(vimtex-]N)", mode = { "n", "o" }, desc = "Next math zone end", ft = "tex" },
    { "[n", "<plug>(vimtex-[n)", mode = { "n", "o" }, desc = "Previous math zone start", ft = "tex" },
    { "[N", "<plug>(vimtex-[N)", mode = { "n", "o" }, desc = "Previous math zone end", ft = "tex" },

    { "]r", "<plug>(vimtex-]r)", mode = { "n", "o" }, desc = "Next frame environment start", ft = "tex" },
    { "]R", "<plug>(vimtex-]R)", mode = { "n", "o" }, desc = "Next frame environment end", ft = "tex" },
    { "[r", "<plug>(vimtex-[r)", mode = { "n", "o" }, desc = "Previous frame environment start", ft = "tex" },
    { "[R", "<plug>(vimtex-[R)", mode = { "n", "o" }, desc = "Previois frame environment end", ft = "tex" },

    { "]/", "<plug>(vimtex-]/)", mode = { "n", "o" }, desc = "Next LaTeX comment start", ft = "tex" },
    { "]*", "<plug>(vimtex-]star)", mode = { "n", "o" }, desc = "Next LaTeX comment end", ft = "tex" },
    { "[/", "<plug>(vimtex-[/)", mode = { "n", "o" }, desc = "Previous LaTeX comment start", ft = "tex" },
    { "[*", "<plug>(vimtex-[star)", mode = { "n", "o" }, desc = "Previous LaTeX comment end", ft = "tex" },

    { "<LOCALLEADER>t", "", desc = "+VimTex", ft = "tex" },
    { "<LOCALLEADER>tm", "<plug>(vimtex-context-menu)", desc = "Show context menu", ft = "tex" },
    { "<LOCALLEADER>ti", "<plug>(vimtex-info)", desc = "Show project info", ft = "tex" },
    { "<LOCALLEADER>tI", "<plug>(vimtex-info-full)", desc = "Show info for all projects", ft = "tex" },
    { "<LOCALLEADER>td", "<plug>(vimtex-doc-package)", desc = "Show package documentation", ft = "tex" },
    { "<LOCALLEADER>tr", ":VimtexRefreshFolds<CR>", desc = "Refresh folds", ft = "tex" },
    { "<LOCALLEADER>tt", "<plug>(vimtex-toc-toggle)", desc = "Toggle table of contents", ft = "tex" },
    { "<LOCALLEADER>tT", "<plug>(vimtex-toc-open)", desc = "Open table of contents", ft = "tex" },

    { "<LOCALLEADER>tl", "<plug>(vimtex-log)", desc = "Open log", ft = "tex" },
    { "<LOCALLEADER>tc", "", desc = "+Compile", ft = "tex" },
    { "<LOCALLEADER>tcc", "<plug>(vimtex-compile)", desc = "Compile", ft = "tex" },
    { "<LOCALLEADER>tcs", "<plug>(vimtex-compile-ss)", desc = "Single shot compile", ft = "tex" },
    { "<LOCALLEADER>tcs", "<plug>(vimtex-compile-selected)", mode = { "v" }, desc = "Compile selected", ft = "tex" },
    { "<LOCALLEADER>tco", "<plug>(vimtex-compile-output)", desc = "Show compile output", ft = "tex" },

    { "<LOCALLEADER>ts", "<plug>(vimtex-stop)", desc = "Stop compilation", ft = "tex" },
    { "<LOCALLEADER>tS", "<plug>(vimtex-stop-all)", desc = "Stop all compilations", ft = "tex" },
    { "<LOCALLEADER>to", "<plug>(vimtex-status)", desc = "Show compilation status", ft = "tex" },
    { "<LOCALLEADER>tO", "<plug>(vimtex-status-all)", desc = "Show status for all projects", ft = "tex" },

    { "<LOCALLEADER>tk", "<plug>(vimtex-clean)", desc = "Clean auxiliary files", ft = "tex" },
    { "<LOCALLEADER>tK", "<plug>(vimtex-clean-full)", desc = "Clean auxiliary and output files", ft = "tex" },
    { "<LOCALLEADER>te", "<plug>(vimtex-errors)", desc = "Show errors/warnings", ft = "tex" },
    { "<LOCALLEADER>tv", "<plug>(vimtex-view)", desc = "View PDF", ft = "tex" },
    { "<LOCALLEADER>tr", "<plug>(vimtex-reload)", desc = "Reload VimTeX scripts", ft = "tex" },
    { "<LOCALLEADER>tR", "<plug>(vimtex-reload-state)", desc = "Reload state for current buffer", ft = "tex" },

    { "<LOCALLEADER>tw", "", desc = "+Count", ft = "tex" },
    { "<LOCALLEADER>twl", ":VimtexCountLetters<CR>", desc = "Count letters/characters", ft = "tex" },
    { "<LOCALLEADER>tww", ":VimtexCountWords<CR>", desc = "Count words", ft = "tex" },
    { "<LOCALLEADER>twL", ":VimtexCountLetters!<CR>", desc = "Count letters detailed", ft = "tex" },
    { "<LOCALLEADER>twW", ":VimtexCountWords!<CR>", desc = "Count words detailed", ft = "tex" },

    -- { "<localleader>tl", "<plug>(vimtex-imaps-list)", desc = "List insert mode mappings", ft = {"tex"} },
    { "<LOCALLEADER>ta", "<plug>(vimtex-toggle-main)", desc = "Toggle main file", ft = "tex" },
    { "<LOCALLEADER>tC", ":VimtexClearCache ", desc = "Clear cache (specify name)", silent = false, ft = "tex" },
  },
  ft = "tex",
  init = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_mappings_enabled = 0
    vim.g.vimtex_imaps_enabled = 0
    vim.g.vimtex_indent_enabled = 1
    vim.g.vimtex_format_enabled = 1
    vim.g.vimtex_completion = 0
  end,
}

local typst = {
  { "kaarmu/typst.vim", ft = { "typst" } },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "0.3.*",
    keys = {
      { "<LOCALLEADER>t", "", desc = "+TypstPreview", ft = "typst" },
      { "<LOCALLEADER>tu", ":TypstPreviewUpdate<CR>", desc = "Typst: Update binaries", ft = "typst" },

      { "<LOCALLEADER>tP", ":TypstPreview<CR>", desc = "Start preview", ft = "typst" },
      { "<LOCALLEADER>t<C-P>", ":TypstPreviewStop<CR>", desc = "Stop preview", ft = "typst" },
      { "<LOCALLEADER>tp", ":TypstPreviewToggle<CR>", desc = "Toggle preview", ft = "typst" },

      { "<LOCALLEADER>tC", ":TypstPreviewFollowCursor<CR>", desc = "Enable follow cursor", ft = "typst" },
      { "<LOCALLEADER>t<C-C>", ":TypstPreviewNoFollowCursor<CR>", desc = "Disable follow cursor", ft = "typst" },
      { "<LOCALLEADER>tc", ":TypstPreviewFollowCursorToggle<CR>", desc = "Toggle follow cursor", ft = "typst" },
      { "<LOCALLEADER>ts", ":TypstPreviewSyncCursor<CR>", desc = "Sync preview with cursor", ft = "typst" },
    },
    build = function() require("typst-preview").update() end,
    opts = {
      debug = false,
      get_root = function(path_of_main_file) return vim.fn.fnamemodify(path_of_main_file, ":p:h") end,
    },
  },
}

local log = {
  {
    "fei6409/log-highlight.nvim",
    enabled = false,
    ft = { "log" },
  },
}

local pkl = {
  {
    "https://github.com/apple/pkl-neovim",
    ft = { "pkl" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    build = function() vim.cmd("TSInstall! pkl") end,
  },
}

local markdown = {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    keys = {
      { "<LOCALLEADER>m", "", desc = "+Markdown Preview", ft = "markdown" },
      { "<LOCALLEADER>mP", ":MarkdownPreview<CR>", desc = "Markdown Preview", ft = "markdown" },
      { "<LOCALLEADER>m<C-P>", ":MarkdownPreviewStop<CR>", desc = "Markdown Preview Stop", ft = "markdown" },
      { "<LOCALLEADER>mp", ":MarkdownPreviewToggle<CR>", desc = "Markdown Preview Toggle", ft = "markdown" },
    },
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    config = function()
      local home = os.getenv("HOME")
      vim.g.mkdp_markdown_css = home .. "/.config/nvim/style/markdown.css"
      vim.g.mkdp_highlight_css = home .. "/.config/nvim/style/highlight.css"
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_auto_close = 1
    end,
  },
  {
    "Kicamon/markdown-table-mode.nvim",
    ft = { "markdown" },
    cmd = { "Mtm" },
    keys = {
      { "<LOCALLEADER>m", "", desc = "+Markdown Preview", ft = "markdown" },
      { "<LOCALLEADER>mt", ":Mtm<CR>", desc = "Markdown Table Mode", ft = "markdown" },
    },
    config = function() require("markdown-table-mode").setup() end,
  },
}

local yaml = {
  "cuducos/yaml.nvim",
  ft = { "yaml" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}
local help = {
  "OXY2DEV/helpview.nvim",
  ft = "help",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}

local cmake = {
  "Civitasv/cmake-tools.nvim",
  init = function()
    local loaded = false
    local function check()
      local cwd = vim.uv.cwd()
      if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
        require("lazy").load({ plugins = { "cmake-tools.nvim" } })
        loaded = true
      end
    end
    check()
    vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
        if not loaded then
          check()
        end
      end,
    })
  end,
  opts = {},
}

local json = {
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
    cmd = { "JqxList", "JqxQuery" },
    keys = {
      { "<LOCALLEADER>j", "", desc = "+Jqx", ft = { "json", "yaml" } },
      { "<LOCALLEADER>jl", "<CMD>JqxList<CR>", desc = "Jqx list", ft = { "json", "yaml" } },
    },
  },
}

return {
  swift,
  cmake,
  tex,
  kitty,
  typst,
  log,
  pkl,
  markdown,
  yaml,
  help,
  json,
}
