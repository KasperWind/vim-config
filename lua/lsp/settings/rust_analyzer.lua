return {
    on_init = function (client)
        local path = client.workspace_folders[1].name

        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        return true
    end,
	settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                target = "thumbv7em-none-eabihf",
                buildScripts = {
                    enable = true,
                },
            },
            check = {
                allTargets = true,
            },
            procMacro = {
                enable = true,
            },
        },
	},
}
