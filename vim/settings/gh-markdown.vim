" Support for github flavored markdown
" via https://github.com/jtratner/vim-flavored-markdown
augroup markdown
    au!
    au BufNewFile,BufRead *.wiki,*.md,*.markdown setlocal filetype=ghmarkdown
augroup END
