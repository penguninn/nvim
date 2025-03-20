-- Setup our JDTLS server any time we open up a java file
vim.cmd([[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'config.jdtls'.setup_jdtls()
        autocmd FileType html,css,javascript,typescript,javascriptreact,typescriptreact setlocal tabstop=2 shiftwidth=2 expandtab
    augroup end
]])
