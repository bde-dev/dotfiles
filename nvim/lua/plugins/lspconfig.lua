return {
  {
    "neovim/nvim-lspconfig",
    --   ---@class PluginLspOpts
    opts = {
      --     ---@type lspconfig.options
      servers = {
        pyright = {},
        bashls = {},
        gopls = {},
        bicep = {},
        yamlls = {},
        marksman = {},
        powershell_es = {},
        --azure_pipelines_ls = {},
        terraformls = {
          filetypes = { "terraform", "hcl" },
        },
        helm_ls = {},
        csharp_ls = {},
        ansiblels = {},
        dockerls = {},
        docker_compose_language_service = {},
      },
    },
  },
}
