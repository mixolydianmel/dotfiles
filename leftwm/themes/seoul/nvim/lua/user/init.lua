return {
  colorscheme = "seoul256",
  lsp = {
    skip_setup = { "clangd", "rust_analyzer", "jdtls" },
    ["server-settings"] = {
      clangd = {
        capabilities = {
          offsetEncoding = "utf-8",
        },
      },

      -- set jdtls server settings
      jdtls = function()

        -- use this function notation to build some variables
        local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
        local root_dir = require("jdtls.setup").find_root(root_markers)

        -- calculate workspace dir
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
        os.execute("mkdir " .. workspace_dir)

        -- get the mason install path
        local install_path = require("mason-registry").get_package("jdtls"):get_install_path()

        -- get the current OS
        local os
        if vim.fn.has "macunix" then
          os = "mac"
        elseif vim.fn.has "win32" then
          os = "win"
        else
          os = "linux"
        end

        -- return the server config
        return {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-javaagent:" .. install_path .. "/lombok.jar",
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar",
            vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
            "-configuration",
            install_path .. "/config_" .. os,
            "-data",
            workspace_dir,
          },
          root_dir = root_dir,
        }
      end,
    },
  },

  options = {
    opt = {
      guifont = "JetBrainsMono Nerd Font:h24",
      conceallevel = 2,
      background = "dark",
    },

    g = {
      catppuccin_flavor = "mocha",
      mkdp_browserfunc = 'OpenMarkdownPreview',
      mkdp_auto_close = 1,
      codeium_no_map_tab = true,
      codeium_filetypes = {
        norg = false,
        markdown = false,
      },
      seoul256_disable_background = true,
    },
  },

  highlights = {
    init = function()
      local normal = astronvim.get_hlgroup("Normal")
      local fg, bg = normal.fg, normal.bg
      local light = astronvim.get_hlgroup("LineNrAbove")
      local light_fg, light_bg = light.fg, light.bg
      return {
        CodeiumSuggestion = { fg = light_fg },
      }
    end
  },

  plugins = {
    init = {
      {
        "p00f/clangd_extensions.nvim",
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
          require("clangd_extensions").setup {
            server = astronvim.lsp.server_settings "clangd",
          }
        end,
      },

      {
        "simrat39/rust-tools.nvim",
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
          require("rust-tools").setup {
            server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
          }
        end,
      },

      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup {}
        end,
      },

      {
        "shaunsingh/seoul256.nvim",
        config = function()
          require("seoul256")
        end
      },

      {
        "elkowar/yuck.vim",
      },

      {
        "eraserhd/parinfer-rust",
        run = 'cargo build --release',
      },

      {
        "weirongxu/plantuml-previewer.vim",
        requires = {
          "aklt/plantuml-syntax",
          "tyru/open-browser.vim"
        }
      },

      {
        "jbyuki/venn.nvim"
      },

      {
        "mipmip/vim-scimark"
      },

      {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
      },

      {
        "lukas-reineke/headlines.nvim",
        config = function()
          require('headlines').setup()
        end,
      },

      {
        "nvim-lua/popup.nvim"
      },

      {
        "renerocksai/calendar-vim",
      },

      {
        "nvim-telescope/telescope-media-files.nvim",
        config = function()
          require('telescope').load_extension('media_files')
        end
      },

      {
        "dhruvasagar/vim-table-mode",
      },

      {
        'andweeb/presence.nvim'
      },

      {
        "folke/twilight.nvim",
        config = function()
          require("twilight").setup {}
        end,
      },

      {
        "folke/zen-mode.nvim",
        config = function()
          require("zen-mode").setup {}
        end
      },

      {
        "nvim-neorg/neorg",
        ft = "norg",
        after = "nvim-treesitter",
        run = ":Neorg sync-parsers",
        config = function()
            require("neorg").setup {
              load = {
                ["core.defaults"] = {},
                ["core.norg.concealer"] = {},
              }
            }
        end,
      },

      {
        "Exafunction/codeium.vim"
      },

      {
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
          require("nvim-surround").setup({})
        end,
      },

      {
        "tikhomirov/vim-glsl"
      },

      ["mfussenegger/nvim-jdtls"] = { module = "jdtls" }, -- load jdtls on module
    },

    treesitter = {
      ensure_installed = {},
      sync_install = false,
      ignore_install = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      autopairs = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
      indent = {
        enable = false,
      },
      rainbow = {
        enable = false,
      },
      autotag = {
        enable = true,
      },
    },

    ["mason-lspconfig"] = {
      ensure_installed = { "clangd", "rust_analyzer", "jdtls" },
    },
  },

  mappings = {
    n = {
      ["<leader>v"] = { "<cmd>lua Toggle_venn()<CR>", desc = "Toggle Venn mode" },
      ["<leader>m"] = { "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" },
      ["<leader>uz"] = { "<cmd>ZenMode<CR>", desc = "Toggle Zen mode" },
    },
    i = {
      ["<C-l>"] = { "codeium#Accept()", desc = "Accept codeium suggestion", expr = true, silent = true },
    },
  },

  header = {
    "╭─────────────────────────────────────────╮",
    "│     _   ____________ _    ________  ___ │",
    "│    / | / / ____/ __ \\ |  / /  _/  |/  / │",
    "│   /  |/ / __/ / / / / | / // // /|_/ /  │",
    "│  / /|  / /___/ /_/ /| |/ // // /  / /   │",
    "│ /_/ |_/_____/\\____/ |___/___/_/  /_/    │",
    "│                                         │",
    "╰──────────────┬────────────┬─────────────╯",
    "               │  by Caden  │              ",
    "               ╰────────────╯              ",
    "                                           ",
  },

  polish = function()
    function _G.Toggle_venn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd[[setlocal ve=all]]
          -- draw a line on HJKL keystokes
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
          -- draw a box by pressing "f" with visual selection
          vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
        else
          vim.cmd[[setlocal ve=]]
          vim.cmd[[mapclear <buffer>]]
          vim.b.venn_enabled = nil
        end
    end

    vim.api.nvim_exec(
    [[
    au FileType * set fo-=c fo-=r fo-=o
    ]],
    true)

    vim.api.nvim_exec(
    [[
    function OpenMarkdownPreview (url)
      execute "silent ! firefox --new-window " . a:url
    endfunction
    ]],
    true)

    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "java", -- autocmd to start jdtls
      callback = function()
        local config = astronvim.lsp.server_settings "jdtls"
        if config.root_dir and config.root_dir ~= "" then require("jdtls").start_or_attach(config) end
      end,
    })
  end,
}
