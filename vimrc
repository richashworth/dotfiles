" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================

set relativenumber              "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set ff=unix

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader="\\"

map <Leader>jt  <Esc>:%!json_pp -f json -t json -json_opt pretty<CR>

" =============== vim-plug Initialization ===============
" This loads all the plugins specified in ~/.vim/vim-plug.vim
if filereadable(expand("~/.vim/vim-plug.vim"))
  source ~/.vim/vim-plug.vim
endif

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
" if filereadable(expand("~/.vim/vundles.vim"))
"   source ~/.vim/vundles.vim
" endif
" au BufNewFile,BufRead *.vundle set filetype=vim

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
" nnoremap p p=`]<C-o>
" nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

" set foldmethod=indent   "fold based on indent
set foldmethod=manual
set foldnestmax=5       "deepest fold is 3 levels
" set nofoldenable        "dont fold by default
"
augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Custom Settings ========================
so ~/.yadr/vim/settings.vim

" ================ Rich's Settings ========================
set wrap
set tw=100
" Draw a line at 101 columns
set colorcolumn=101
highlight ColorColumn ctermbg=235 guibg=#2c2d27

colo gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE

" ================ Tags ========================

let g:tagbar_ctags_bin='/usr/local/bin/ctags'

let g:tagbar_type_vimwiki = {
      \   'ctagstype':'vimwiki'
      \ , 'kinds':['h:header']
      \ , 'sro':'&&&'
      \ , 'kind2scope':{'h':'header'}
      \ , 'sort':0
      \ , 'ctagsbin':'~/.vim/vwtags.py'
      \ , 'ctagsargs': 'default'
      \ }

" indent guides custom colors
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=16
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=232

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
hi Visual term=reverse cterm=reverse guibg=Grey
" let g:yadr_disable_solarized_enhancements = 1 " enable this if issues with colors
set shell=/usr/local/bin/zsh\ -l

" scalafmt settings
function! StartNailgunScalaFmt()
  execute(':silent! !scalafmt_ng 2>/dev/null 1>/dev/null &')
  execute(':redraw!')
endfunction
call StartNailgunScalaFmt()

let g:formatdef_scalafmt = "'ng scalafmt --stdin'"
let g:formatters_scala = ['scalafmt']

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

autocmd FileType json syntax match Comment +\/\/.\+$+

let g:autoformat_verbosemode = 0 " for error messages
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

noremap <silent><localleader>f :Autoformat<CR>:SortScalaImports<CR>

au BufWritePost *.scala :Autoformat

" Configuration for coc.nvim

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=auto

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" syntastic settings
let g:syntastic_mode_map = { 'mode': 'passive' }

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm.app"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

if exists('$TMUX')
  let &t_SI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=1\x7\<esc>\\"
  let &t_EI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=0\x7\<esc>\\"
else
  let &t_SI = "\<esc>]50;CursorShape=1\x7"
  let &t_EI = "\<esc>]50;CursorShape=0\x7"
endif

let g:vimwiki_list = [{'path':'$HOME/itv-wiki','path_html':'$HOME/itv-wiki_html'}, {'path':'$HOME/vimwiki/vimwiki','path_html':'$HOME/vimwiki/vimwiki_html'}]

let g:tagbar_type_vimwiki = {
      \   'ctagstype':'vimwiki'
      \ , 'kinds':['h:header']
      \ , 'sro':'&&&'
      \ , 'kind2scope':{'h':'header'}
      \ , 'sort':0
      \ , 'ctagsbin': 'python3'
      \ , 'ctagsargsbin':'~/.vim/vwtags.py all'
      \ }

set clipboard=unnamed

set mouse=a
set autochdir

let g:gist_post_private = 1

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

let g:airline#extensions#tabline#enabled = 1
let g:livedown_open = 1

hi Visual term=reverse cterm=reverse guibg=Grey

let g:vista#renderer#enable_icon = 1

autocmd FileType json syntax match Comment +\/\/.\+$+

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175

"
" Support for Tagbar -- https://github.com/majutsushi/tagbar
"
" Hat tip to Leonard Ehrenfried for the built-in ctags deffile:
"    https://leonard.io/blog/2013/04/editing-scala-with-vim/
"
if !exists(':Tagbar')
  finish
endif

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'sro'        : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
\ }

" In case you've updated/customized your ~/.ctags and prefer to use it.
if get(g:, 'scala_use_builtin_tagbar_defs', 1)
  let g:tagbar_type_scala.deffile = expand('<sfile>:p:h:h:h') . '/ctags/scala.ctags'
endif
