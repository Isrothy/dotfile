source ~/.vim/basic_settings.vim
source ~/.vim/indentation_and_format.vim
source ~/.vim/search_settings.vim
source ~/.vim/buffer_settings.vim
source ~/.vim/code_settings.vim
source ~/.vim/keybindings.vim


source ~/.vim/plugin_settings/vim_startify_settings.vim
source ~/.vim/plugin_settings/airline_settings.vim
source ~/.vim/plugin_settings/nerd_tree_settings.vim
source ~/.vim/plugin_settings/vim_rainbow_settings.vim

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END


" lua require('plugins')
" lua require('nvim_comment').setup()
" lua require'lspconfig'.clangd.setup{}
" lua require'lspconfig'.pyright.setup{}
" lua require'lspconfig'.cssmodules_ls.setup{}
" lua require'lspconfig'.dartls.setup{}
" lua require'lspconfig'.cssmodules_ls.setup{}
" lua require'lspconfig'.eslint.setup{}
" lua require'lspconfig'.kotlin_language_server.setup{}
" lua require'lspconfig'.sourcekit.setup{}
" 
" colorscheme nord
