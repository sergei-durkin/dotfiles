return {
    {
        "onsails/lspkind.nvim",
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
            },
            "neovim/nvim-lspconfig",
            "j-hui/fidget.nvim",
        },

        config = function()
            -- Turn on lsp status information
            require("fidget").setup()

            -- Diagnostic keymaps
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<leader><CR>", vim.diagnostic.open_float)
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
            vim.keymap.set("n", "<leader>ca", ":GoCodeAction<CR>", { noremap = true, silent = true })

            local builtin = require("telescope.builtin")

            -- LSP settings.
            local on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end

                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, noremap = true })
                end

                nmap("⌘i", vim.lsp.buf.rename, "[R]e[n]ame")
                -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                nmap("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
                nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
                nmap("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
                nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
                nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
                nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                -- See `:help K` for why this keymap
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

                -- Lesser used LSP functionality
                nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
                nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
                nmap("<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "[W]orkspace [L]ist Folders")

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                    if vim.lsp.buf.format then
                        vim.lsp.buf.format()
                    elseif vim.lsp.buf.formatting then
                        vim.lsp.buf.formatting()
                    end
                end, { desc = "Format current buffer with LSP" })
            end

            -- Setup mason so it can manage external tooling
            require("mason").setup({})

            local utils = require("lspconfig.util")

            local config = {
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                },

                diagnostic = {
                    virtual_text = {
                        spacing = 4,
                        prefix = " ",
                        severity = { min = vim.diagnostic.severity.HINT },
                    },
                    underline = true,
                    update_in_insert = false,
                    severity_sort = true,
                    float = {
                        focusable = true,
                        style = "minimal",
                        border = "rounded",
                        source = "always",
                        header = "",
                        prefix = "",
                        format = function(diagnostic)
                            return string.format(" %s\n%s: %s ", diagnostic.message, diagnostic.source, diagnostic.code)
                        end,
                    },
                    virtual_lines = false,
                },
            }

            vim.diagnostic.config(config.diagnostic)

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { underline = true })

            require("mason-lspconfig").setup()

            -- nvim-cmp supports additional completion capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local lspconfig = require("lspconfig")

            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            local servers = { "clangd", "gopls", "lua_ls" }
            for _, lsp in ipairs(servers) do
                vim.lsp.config(lsp, {
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end

            vim.lsp.config("gopls", {
                on_attach = on_attach,
                capabilities = capabilities,

                settings = {
                    gopls = {
                        buildFlags = { "-tags=armtracer,integration,wireinject" },
                        completeUnimported = true,
                        usePlaceholders = true,
                        semanticTokens = true,
                        analyses = {
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
            })

            vim.lsp.config("lua_ls", {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            -- Setup LSP for brief language (internal Avito)
            require("lspconfig.configs").briefls = {
                default_config = {
                    -- cmd = { "nc", "127.0.0.1", "8833" }, -- Uncommend for debug
                    cmd = { "briefls" },
                    filetypes = { "brief" },
                    root_dir = function(fname)
                        return utils.root_pattern(".git")(fname)
                    end,
                    single_file_support = true,
                    capabilities = {
                        workspace = {
                            didChangeWatchedFiles = {
                                dynamicRegistration = true,
                            },
                        },
                    },
                },
                settings = {},
            }

            vim.lsp.config("briefls", {
                on_attach = on_attach,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "sh",
                callback = function()
                    vim.lsp.start({
                        name = "bash-language-server",
                        cmd = { "bash-language-server", "start" },
                    })
                end,
            })
        end,
    },
}
