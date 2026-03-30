-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Configure Nushell as the default terminal shell
vim.o.shell = "/opt/homebrew/bin/nu"
vim.o.shellcmdflag = "--config ~/.config/nushell/config.nu -c"
