let mapleader = ','
noremap \ ,

" Reread the configuration file
noremap \r :source ~/.config/nvim/init.vim<cr>

" https://github.com/junegunn/vim-plug
" Automatic installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" VIM-PLUG
call plug#begin('~/.local/share/nvim/plugged')
" Configuration
Plug 'https://github.com/tpope/vim-sensible'

" Utils
Plug 'https://github.com/scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
" DEPENDENCY: https://github.com/scrooloose/nerdtree
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'https://github.com/junegunn/fzf.vim'

" Visual
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/google/vim-searchindex'
Plug 'https://github.com/vim-python/python-syntax'

" Editing
" https://www.csslayer.info/wordpress/fcitx-dev/how-to-use-fcitx-on-ubuntu-17-10/
Plug 'https://github.com/lilydjwg/fcitx.vim'
Plug 'https://github.com/terryma/vim-multiple-cursors'
Plug 'https://github.com/terryma/vim-expand-region'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'https://github.com/tpope/vim-speeddating'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-abolish'
" DEPENDENCY: https://github.com/tpope/vim-repeat
" Plug 'https://github.com/svermeulen/vim-easyclip'
" USAGE: http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'https://github.com/godlygeek/tabular'

" Navigation
" DEPENDENCY: https://github.com/tpope/vim-repeat
Plug 'https://github.com/easymotion/vim-easymotion'

" Misc
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/Konfekt/FastFold'

" Syntax checking
Plug 'https://github.com/vim-syntastic/syntastic'

" Auto-completion
Plug 'https://github.com/Valloric/YouCompleteMe'

" Programming
" DEPENDENCY: https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst
" Plug 'https://github.com/ludovicchabant/vim-gutentags'
" DEPENDENCY: https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/tpope/vim-endwise'

" Git
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/airblade/vim-rooter'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-rhubarb'

" Python
Plug 'https://github.com/tmhedberg/SimpylFold'
" DEPENDENCY: https://github.com/timothycrosley/isort
Plug 'https://github.com/fisadev/vim-isort', {'for': 'python'}
Plug 'https://github.com/Chiel92/vim-autoformat'

" Emmet
Plug 'https://github.com/mattn/emmet-vim'

" Color themes
Plug 'https://github.com/rakr/vim-one'
" Plug 'https://github.com/morhetz/gruvbox'
" Plug 'https://github.com/NLKNguyen/papercolor-theme'
call plug#end()

" Reduce upate time from 4s to 100ms
set updatetime=100
" Copy to a X11 "+ clipboard register
set clipboard=unnamedplus

" Number lines
set number
" Show partial command in status line
set showcmd

" Case-insensitive search
set ignorecase
" Case-sensitive if search contains an uppercase letter
set smartcase

" Switch between modified buffers without bang
set hidden

" Insert one space after a '.', '?' and '!' with a join command.
set nojoinspaces

" Expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" edit a file in a new buffer
nmap <leader><leader>ew :e %%
" edit a file in a new tab
nmap <leader><leader>et :tabe %%
" edit a file in a horizontal split
nmap <leader><leader>es :sp %%
" edit a file in a vertical split
nmap <leader><leader>ev :vsp %%

" Yank from cursor to end of line like 'C' and 'D'
nnoremap Y y$

" Folding
" Open all folds by default
" set foldlevel=99
set foldlevelstart=99

set foldmethod=syntax
let g:markdown_folding = 1
let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1

" TAB
" Use 4 spaces instead of tab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

autocmd FileType html setlocal tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType typescript setlocal tabstop=2 shiftwidth=2

" WILDMENU
" 'wildmenu' is enabled in 'vim-sensible' plugin.
" Complete till longest common string and start 'wildmenu'.
" If pressing TAB doesn't result in a longer string,
" complete the next full match from wild menu.
" After the last match the original string is used and then the first match again.
set wildmode=longest:full,full

" COLOR THEMES
" NOTE: Disable 'Use transparency from system theme' color setting in gnome-terminal
set termguicolors
set background=light

"one
colorscheme one
let g:airline_theme='one'

" python-syntax
let g:python_highlight_all = 1

" AIRLINE
" https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1

" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'

" INDENTLINE
let g:indentLine_char = '⎸'

" VIM-EASYMOTION
map <leader> <Plug>(easymotion-prefix)

" NERDTREE
nnoremap <space>n :NERDTreeToggle<CR>

" FZF
nnoremap <space>f :Files<cr>
nnoremap <space>p :Lines<cr>
nnoremap <space>e :Buffers<cr>
nnoremap <space>s :Tags<cr>

" SYNTASTIC
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" python
" https://github.com/PyCQA/flake8
" https://github.com/PyCQA/pylint
" https://github.com/PyCQA/bandit
" let g:syntastic_python_checkers = ['flake8', 'pylint', 'bandit']
let g:syntastic_python_checkers = ['flake8']
" https://github.com/PyCQA/pylint-django
" let g:syntastic_python_pylint_args = '--load-plugins pylint_django'

" sh
" https://github.com/koalaman/shellcheck

" ULTISNIPS
" Trigger configuration. Do not use <tab> with YouCompleteMe.
" let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"

" YOUCOMPLETEME
" cd ~/.local/share/nvim/plugged/YouCompleteMe/ && python3 install.py
let g:ycm_min_num_of_chars_for_completion = 1
" Completion for programming language's keyword
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
" Read tags from Ctags file
" let g:ycm_collect_identifiers_from_tags_files = 1

" DEOPLETE
" let g:deoplete#enable_at_startup = 1

" TAGBAR
" Put the cursor in the Tagbar window when it is opened
let g:tagbar_autofocus = 1

" VIM-GITGUTTER
" Suppress the signs when a file has more than 1000 changes
let g:gitgutter_max_signs = 1000

" SIMPYLFOLD
" let g:SimpylFold_fold_docstring = 0
" let g:SimpylFold_fold_import = 0

" VIM-ISORT
let g:vim_isort_config_overrides = { 'multi_line_output': 3,'include_trailing_comma': 1, 'force_grid_wrap': 0, 'use_parentheses': 1, 'line_length': 120}
let g:vim_isort_python_version = 'python3'
noremap <leader>i :Isort<CR>

" VIM-AUTOFORMAT
" Enable debug mode
" let g:autoformat_verbosemode=1
" Disable the fallback to vim's indent file
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
" python
" https://github.com/ambv/black
let g:formatterpath = ['~/bin/']
let g:formatters_python = ['black']
let g:formatdef_black = '"black --quiet --line-length=120 -"'
" javascript
" https://github.com/beautify-web/js-beautify
let g:formatters_javascript = ['jsbeautify_javascript']
let g:formatdef_jsbeautify_javascript = '"js-beautify --indent-size=2 --e4x -"'
" json
let g:formatters_json = ['jsbeautify_json']
let g:formatdef_jsbeautify_json = '"js-beautify --indent-size=2 -"'
" Next items need the npm (not python) jsbeautify version to work
" html
let g:formatters_html = ['jsbeautify_html']
let g:formatdef_jsbeautify_html = '"html-beautify --indent-size=2 -"'
" css
let g:formatters_css = ['jsbeautify_css']
let g:formatdef_jsbeautify_css = '"css-beautify --indent-size=2 -"'

noremap <leader>o :Autoformat<CR>
