-- DAP Go configuration fix for debugging main.go
local dap = require('dap')

-- Configure Go adapter
dap.adapters.go = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

-- Configure Go debug configurations
dap.configurations.go = {
  {
    type = "go",
    name = "Debug Current File",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug Package",
    request = "launch",
    program = "${fileDirname}",
  },
  {
    type = "go",
    name = "Debug main.go",
    request = "launch",
    program = "${workspaceFolder}/main.go",
  },
}

-- Setup dap-go if available
local ok, dap_go = pcall(require, "dap-go")
if ok then
  dap_go.setup({
    dap_configurations = {
      {
        type = "go",
        name = "Debug Current File (dap-go)",
        request = "launch",
        program = "${file}",
      },
    },
  })
end

print("DAP Go configuration loaded")