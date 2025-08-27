return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      terraform = { "terraform_fmt" },
      tf = { "terraform_fmt" },
      ["terraform-vars"] = { "terraform_fmt" },
      hcl = { "hclfmt", "terraform_fmt" }, -- Try hclfmt first, fallback to terraform_fmt
    },
    formatters = {
      terraform_fmt = {
        command = "terraform",
        args = { "fmt", "-" },
        stdin = true,
      },
    },
  },
}
