let mapleader=' '

" Reread the configuration file
noremap \` :source ~/.config/nvim/init.vim<cr>

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

    " Visual
    Plug 'https://github.com/altercation/vim-colors-solarized'
    Plug 'https://github.com/vim-airline/vim-airline'
    Plug 'https://github.com/vim-airline/vim-airline-themes'
    Plug 'https://github.com/Yggdroot/indentLine'
    Plug 'https://github.com/google/vim-searchindex'
    Plug 'https://github.com/ap/vim-css-color'
    Plug 'https://github.com/plasticboy/vim-markdown'

    " Editing
    Plug 'https://github.com/tpope/vim-repeat'
    Plug 'https://github.com/tpope/vim-commentary'
    Plug 'https://github.com/tpope/vim-surround'
    Plug 'https://github.com/tpope/vim-unimpaired'
    Plug 'https://github.com/tpope/vim-speeddating'

    Plug 'https://github.com/junegunn/vim-peekaboo'
    Plug 'https://github.com/junegunn/vim-easy-align'

    Plug 'https://github.com/vim-scripts/ReplaceWithRegister'
    Plug 'https://github.com/tommcdo/vim-exchange'

    Plug 'https://github.com/terryma/vim-multiple-cursors'

    Plug 'https://github.com/terryma/vim-expand-region'

    Plug 'https://github.com/wellle/targets.vim'
    Plug 'https://github.com/kana/vim-textobj-user'
    Plug 'https://github.com/kana/vim-textobj-entire'

    Plug 'https://github.com/jiangmiao/auto-pairs'
    Plug 'https://github.com/tpope/vim-endwise'

    " Navigation
    Plug 'https://github.com/justinmk/vim-sneak'
    Plug 'https://github.com/easymotion/vim-easymotion'

    " Autocompletion
    Plug 'https://github.com/Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

    " Utilities
    Plug 'https://github.com/scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
    Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
    Plug 'https://github.com/junegunn/fzf', {'do': {-> fzf#install()}}
    Plug 'https://github.com/junegunn/fzf.vim'
    " Shellcheck must be installed.
    " https://github.com/koalaman/shellcheck
    Plug 'https://github.com/vim-syntastic/syntastic'

    " Snippets
    Plug 'https://github.com/Shougo/neosnippet.vim'
    Plug 'https://github.com/Shougo/neosnippet-snippets'
    " Plug 'https://github.com/SirVer/ultisnips'
    " Plug 'https://github.com/honza/vim-snippets'

    " Git
    Plug 'https://github.com/airblade/vim-gitgutter'
    Plug 'https://github.com/airblade/vim-rooter'
    Plug 'https://github.com/tpope/vim-fugitive'
call plug#end()

" CONFIGURATION
" Reduce upate time from 4s to 100ms
set updatetime=100
" Copy to a X11 "+ clipboard register
set clipboard=unnamedplus
" Switch between modified buffers without bang
set hidden
" Insert one space after a '.', '?' and '!' with a join command.
set nojoinspaces

" Wildmenu
" 'wildmenu' is enabled in 'vim-sensible' plugin.
" Complete till longest common string and start 'wildmenu'.
" If pressing TAB doesn't result in a longer string,
" complete the next full match from wild menu.
" After the last match the original string is used and then the first match again.
set wildmode=longest:full,full

" Search
" Case-insensitive search
set ignorecase
" Case-sensitive if search contains an uppercase letter
set smartcase

" Tab
" Use 4 spaces instead of tab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType html setlocal tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType typescript setlocal tabstop=2 shiftwidth=2

" Folding
" Syntax highlighting items specify folds.
set foldmethod=syntax
" Start editing with all folds open.
set foldlevelstart=99

" VISUAL
" Number lines
set number
" Show partial command in status line
set showcmd
set termguicolors
set background=light
colorscheme solarized
" https://github.com/airblade/vim-gitgutter#sign-column
highlight SignColumn guibg=#fdf6e3
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:indentLine_char='⎸'
" Do not conceal characters (e.g. quotes in JSON file)
let g:indentLine_concealcursor=''
let g:indentLine_conceallevel=0

" EASY-ALIGN
" Start interactive EasyAlign in visual mode (e.g. vipga).
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip).
nmap ga <Plug>(EasyAlign)

" VIM-MULTIPLE-CURSORS
let g:multi_cursor_use_default_mapping=0

" VIM-SNEAK
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" DEOPLETE
let g:deoplete#enable_at_startup=1
" Tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" Show snippets first.
" call deoplete#custom#source('ultisnips', 'rank', 1000)
" call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])

" NERDTREE
nnoremap <leader>n :NERDTreeToggle<CR>

" FZF
nnoremap <leader>f :Files<cr>
nnoremap <leader>p :Lines<cr>
nnoremap <leader>e :Buffers<cr>

" SYNTASTIC
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" ULTISNIPS
" let g:UltiSnipsExpandTrigger='<c-j>'
" let g:UltiSnipsJumpForwardTrigger='<c-b>'
" let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" VIM-GITGUTTER
" Suppress the signs when a file has more than 1000 changes
let g:gitgutter_max_signs=1000

" MAPPINGS
" Yank from cursor to end of line like 'C' and 'D'
nnoremap Y y$
