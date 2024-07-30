" Note: This .vimrc file uses Vim folding. Toggle a fold with `za`.

"*****************************************************************************
"{{{1 VUNDLE PLUGIN MANAGER BEGIN
"*****************************************************************************
"{{{2 Vundle initialization self-load start
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible              " be iMproved, required
filetype off                  " required

let vundle_exists=expand('~/.vim/bundle/Vundle.vim')

if !isdirectory(vundle_exists)
  echoerr "You have to first install Vundle yourself! https://github.com/VundleVim/Vundle.vim"
  execute "q!"
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"}}}2 Vundle initialization self-load end

"*****************************************************************************
"{{{2 Vundle install plugins begin

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"-----------------------------------------------------------------------------
"{{{3 Plugins suggested by https://vim-bootstrap.com/

Plugin 'scrooloose/nerdtree'         " Vim file browser
Plugin 'tpope/vim-fugitive'          " :Gcommit and other similar commands

Plugin 'vim-airline/vim-airline'     " Fancy Vim statusline {{{4
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
" }}}4

Plugin 'airblade/vim-gitgutter'      " Shows Git changed lines in left margin
Plugin 'dense-analysis/ale'          " Asynchronous Lint Engine {{{4
let g:ale_fix_on_save = 0            " Maybe set to 1
let g:ale_linters_explicit = 0       " Maybe set to 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'sh': ['shellcheck'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'css': ['prettier'],
\}
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma --no-semi es5'
" }}}4

Plugin 'jelera/vim-javascript-syntax'
Plugin 'derekwyatt/vim-scala'        " Scala

"-----------------------------------------------------------------------------
"{{{3 garrettheath4 custom plugins

Plugin 'jaredgorski/SpaceCamp'         " Modern Vim colorscheme
Plugin 'machakann/vim-columnmove'      " Move cursor in vertical-only direction by M-f,t,F,T, `;`, `,`
Plugin 'godlygeek/tabular'             " :Tabularize to align text tables
Plugin 'elzr/vim-json'                 " JSON
Plugin 'maksimr/vim-jsbeautify'        " :call JsBeautify()
Plugin 'othree/xml.vim'                " XML
Plugin 'AnsiEsc.vim'                   " :AnsiEsc to Interpret ANSI esc sequences
Plugin 'Xuyuanp/nerdtree-git-plugin'   " Git plugin for nerdtree (nerdtree req'd)
"Plugin 'plasticboy/vim-markdown'      " Better Markdown support?
Plugin 'masukomi/vim-markdown-folding' " Enables section folding in Markdown files
"Plugin 'nathangrigg/vim-beancount'     " beancount syntax support (plaintext accounting CLI tool)
"Plugin 'dzeban/vim-log-syntax'         " Highlight Error and Warning lines in log files
Plugin 'iamkarlson/vim-log-syntax'     " Highlight Error and Warning lines in log files

Plugin 'ctrlpvim/ctrlp.vim'            " Ctrl+P for fuzzy file finder (ag: the Silver Searcher)  {{{4
" source: https://thoughtbot.com/blog/faster-grepping-in-vim
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" }}}4


"-----------------------------------------------------------------------------
"{{{3 OS-specific plugins

if has("mac")
  " List Mac-specific Vundle plugin packages here
  Plugin 'darfink/vim-plist'
endif

"}}}2 Vundle install plugins end
"*****************************************************************************

"*****************************************************************************
"{{{2 Vundle finish initialization

" All of your Plugins must be added before the following line
call vundle#end()             " required
filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"-----------------------------------------------------------------------------
"{{{3 Plugin-specific tweaks/functions
" Note: This section *must* go after call `vundle#end()` above

" Check if vim-arkdown-folding plugin is loaded
" Source: https://vi.stackexchange.com/a/14143
if match(&runtimepath, 'vim-markdown-folding') != -1
  " Source: ChatGPT on 2024-07-09
  " Function to open folds of top-level headings (# and ##) for Markdown files
  function! OpenTopLevelHeadings()
      " Go to the first line
      normal! gg
      " Loop through lines
      while 1
          " Open the fold if it is a top-level heading
          if match(getline('.'), '^##\? ') == 0
              normal! zo
          endif
          " Move to the next line
          normal! j
          " Break the loop if we are at the end of the file
          if line('.') == line('$')
              break
          endif
      endwhile
  endfunction

  " Hook the function to the FileType event for Markdown files
  autocmd FileType markdown call OpenTopLevelHeadings()
  " Or: Hook the function to the FileType event for Markdown files WITH A
  " DELAY
  "autocmd FileType markdown call timer_start(100, {->OpenTopLevelHeadings() })
  " OR: Hook the function to the BufReadPost and BufWinEnter events for Markdown
  " files
  "autocmd BufReadPost,BufWinEnter *.md call OpenTopLevelHeadings()
  " OR: Hook the function to the BufReadPost and BufWinEnter events for Markdown
  " files WITH A DELAY
  "autocmd BufReadPost,BufWinEnter *.md call timer_start(100, {-> OpenTopLevelHeadings() })
  " OR: Use VimEnter command to call the function *after* plugins are loaded
  " Source: https://stackoverflow.com/a/69557520
  "autocmd VimEnter *.md call OpenTopLevelHeadings()
endif

"}}}2 Vundle finish initialization
"*****************************************************************************

"*****************************************************************************
"}}}1 VUNDLE PLUGIN MANAGER END
"*****************************************************************************

"*****************************************************************************
"{{{1 GENERAL VIM CONFIGURATIONS
"*****************************************************************************

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup  " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif
set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set guioptions-=T
  " acceptable dark colorschemes are: industry, koehler, lunaperche, torte,
  "                                   ron, darkblue, zaibatsu, and sorbet.
  " SpaceCamp looks good in vim but not vimdiff with `cursorline` enabled.
  colorscheme industry
  "try
  "  colorscheme SpaceCamp
  "catch /^Vim\%((\a\+)\)\=:E185/
  "  colorscheme koehler
  "endtry
  syntax on
  hi Error guifg=Yellow guibg=Red ctermfg=8 ctermbg=1
  set hlsearch
  set cursorline
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  "filetype plugin indent on         " Already turned on in Vundle block at top

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent  " always set autoindenting on

endif " has("autocmd")

" Alter the sort sequence for the Netrw Directory Listing
" g:netrw_sort_sequence = [\/]$,\<core\%(\.\d\+\)\=\>,\.c$,\.cpp$,\.h$,\.txt$,\.in$,\.out$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$

set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set copyindent
set preserveindent
set nojoinspaces    " nojoinspaces => only 1 period after spaces when reformatting
set incsearch
set scrolloff=1
set exrc
set backspace=2
set number

set list            " Show formatting characters
" Show <Tab> as >-- and trailing spaces as ~
set listchars=tab:>-,trail:~,extends:>,precedes:<
" Set color of eol, extends, and precedes to black (visible only when editing line)
highlight NonText    ctermfg=0 guifg=Black
" Set color of nbsp, tab, and trail to dark gray
highlight SpecialKey ctermfg=8 guifg=DarkGray

" Reduce number of confusing colors used in vimdiff
" Source: https://stackoverflow.com/a/17183382
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

set modeline
set modelines=3

if has("gui_running") && !exists("mvim")
  set autochdir
  set lines=70
  " Source: https://stackoverflow.com/a/2019438
  if &diff
    set columns=172
  else
    set columns=86
  endif
  if has("mac")
    " The `-monospace-` keyword means to use the system native monospace font,
    " which is SF Mono in new macOS versions. See `:help gui-font`
    set guifont=-monospace-:h13
  endif
endif

" vim: set tabstop=2 shiftwidth=2 vts=2 smarttab softtabstop=2 shiftround expandtab foldmethod=marker:
