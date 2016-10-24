" VUNDLE PLUGIN MANAGER START "

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" List Vundle plugin packages here

" tabular: #MakeTextTablesPrettyAgain
Plugin 'godlygeek/tabular'
" vim-json: #MakeJsonPrettyAgain
Plugin 'elzr/vim-json'
" xml.vim: #MakeXmlPrettyAgain
Plugin 'othree/xml.vim'
" AnsiEsc.vim: #MakeANSIEscapeSequencesPrettyAgain
Plugin 'AnsiEsc.vim'
" syntastic: Syntax checking plugin (includes ShellCheck support for scripts)
Plugin 'scrooloose/syntastic'
" Coding language-specific plugins: vim-scala
Plugin 'derekwyatt/vim-scala'
" vim-fugitive: Git wrapper
Plugin 'tpope/vim-fugitive'
" nerdtree: Vim file browser
Plugin 'scrooloose/nerdtree'
" nerdtree-git-plugin: Git plugin for nerdtree (requires nerdtree obviously)
Plugin 'Xuyuanp/nerdtree-git-plugin'

if has("mac")
  " List Mac-specific Vundle plugin packages here
  Plugin 'darfink/vim-plist'
endif


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

" VUNDLE PLUGIN MANAGER END   "

" Plugin-specific configurations

" Syntastic configurations
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
if has("multi_byte")
	let g:syntastic_error_symbol = "✗✗"
	let g:syntastic_warning_symbol = "◊◊"
else
	let g:syntastic_error_symbol = "!>"
	let g:syntastic_warning_symbol = "~>"
endif
" Check the syntax with Syntastic using the shortcut <leader>c (usually \c)
nmap <leader>c :SyntasticCheck<CR>

" General Vim configurations

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

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
  color koehler
  syntax on
  hi Error guifg=Yellow guibg=Red ctermfg=8 ctermbg=1
  set hlsearch
  set cul
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

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Alter the sort sequence for the Netrw Directory Listing
" g:netrw_sort_sequence = [\/]$,\<core\%(\.\d\+\)\=\>,\.c$,\.cpp$,\.h$,\.txt$,\.in$,\.out$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$


" ai=Auto Indent, si=Smart Indent, ci=C code indent, pi=Preserve Indent
set ts=5
set sw=5
set ai
set si
set ci
set pi
" is=Incremental Search
set is
set so=2
set ru
set ex
set backspace=2
set nu
" list=Show formatting characters
set list
" Show <Tab> as >-- and trailing spaces as ~
set listchars=tab:>-,trail:~,extends:>,precedes:<
" Set color of eol, extends, and precedes to black (visible only when editing line)
highlight NonText    ctermfg=0 guifg=Black
" Set color of nbsp, tab, and trail to dark gray
highlight SpecialKey ctermfg=8 guifg=DarkGray
set ml
set mls=3
if has("gui_running") && !exists("mvim")
  set acd
  set lines=76
  set co=85
endif
