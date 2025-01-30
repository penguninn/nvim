local function get_jdtls()
    local mason_registry = require("mason-registry")
    local jdtls = mason_registry.get_package("jdtls")
    local jdtls_path = jdtls:get_install_path()
    local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    -- Declare white operating system we are using, windows use win, macos use mac
    local SYSTEM = "win"
    local config = jdtls_path .. "/config_" .. SYSTEM
    local lombok = jdtls_path .. "/lombok.jar"
    return launcher, config, lombok
end

local function get_bundles()
    local mason_registry = require("mason-registry")
    local java_debug = mason_registry.get_package("java-debug-adapter")
    local java_debug_path = java_debug:get_install_path()
    local bundles = {
        vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
    }

    -- Find the Java Test package in the Mason Registry
    local java_test = mason_registry.get_package("java-test")
    -- Obtain the full path to the directory where Mason has downloaded the Java Test binaries
    local java_test_path = java_test:get_install_path()
    -- Add all of the Jars for running tests in debug mode to the bundles list
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))

    return bundles
end

local function get_workspace()
    local home = vim.fn.expand("~")
    local workspace_path = home .. "/workspaces/java/"
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = workspace_path .. project_name
    return workspace_dir
end

local function java_keymaps()
    vim.cmd(
        "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
    )
    vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
    vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
    vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")
    vim.keymap.set(
        "n",
        "<leader>Jo",
        "<Cmd> lua require('jdtls').organize_imports()<CR>",
        { desc = "[J]ava [O]rganize Imports" }
    )
    vim.keymap.set(
        "n",
        "<leader>Jv",
        "<Cmd> lua require('jdtls').extract_variable()<CR>",
        { desc = "[J]ava Extract [V]ariable" }
    )
    vim.keymap.set(
        "v",
        "<leader>Jv",
        "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>",
        { desc = "[J]ava Extract [V]ariable" }
    )
    vim.keymap.set(
        "n",
        "<leader>JC",
        "<Cmd> lua require('jdtls').extract_constant()<CR>",
        { desc = "[J]ava Extract [C]onstant" }
    )
    vim.keymap.set(
        "v",
        "<leader>JC",
        "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>",
        { desc = "[J]ava Extract [C]onstant" }
    )
    vim.keymap.set(
        "n",
        "<leader>Jt",
        "<Cmd> lua require('jdtls').test_nearest_method()<CR>",
        { desc = "[J]ava [T]est Method" }
    )
    vim.keymap.set(
        "v",
        "<leader>Jt",
        "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>",
        { desc = "[J]ava [T]est Method" }
    )
    vim.keymap.set("n", "<leader>JT", "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "[J]ava [T]est Class" })
    vim.keymap.set("n", "<leader>Ju", "<Cmd> JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config" })
end

local function setup_jdtls()
    local jdtls = require("jdtls")
    local launcher, os_config, lombok = get_jdtls()
    local workspace_dir = get_workspace()
    local bundles = get_bundles()
    local root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
    local capabilities = {
        workspace = {
            configuration = true,
        },
        textDocument = {
            completion = {
                snippetSupport = false,
            },
        },
    }
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    for k, v in pairs(lsp_capabilities) do
        capabilities[k] = v
    end
    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    local cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. lombok,
        "-jar",
        launcher,
        "-configuration",
        os_config,
        "-data",
        workspace_dir,
    }

    local settings = {
        java = {
            format = {
                enabled = true,
            },
            eclipse = {
                downloadSource = true,
            },
            maven = {
                downloadSources = true,
            },
            signatureHelp = {
                enabled = true,
            },
            contentProvider = {
                preferred = "fernflower",
            },
            saveActions = {
                organizeImports = true,
            },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
                importOrder = {
                    "java",
                    "jakarta",
                    "javax",
                    "com",
                    "org",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
            },
            referencesCodeLens = {
                enabled = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all",
                },
            },
        },
    }

    local init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
    }

    local on_attach = function(_, bufnr)
        java_keymaps()
        require("jdtls.dap").setup_dap()
        require("jdtls.dap").setup_dap_main_class_configs()
        require("jdtls.setup").add_commands()
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.java" },
            callback = function()
                local _, _ = pcall(vim.lsp.codelens.refresh)
            end,
        })
    end
    local config = {
        cmd = cmd,
        root_dir = root_dir,
        settings = settings,
        capabilities = capabilities,
        init_options = init_options,
        on_attach = on_attach,
    }

    require("jdtls").start_or_attach(config)
end

return {
    setup_jdtls = setup_jdtls,
}
