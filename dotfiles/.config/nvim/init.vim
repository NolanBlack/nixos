syntax on set vb
filetype on
set spell spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add
set tabstop=4
set softtabstop=4 
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set showmatch
set scrolloff=8
"set mouse=a


set signcolumn=yes
set colorcolumn=80
set cursorline

set termguicolors

" use 256 colors in terminal
"if !has("gui_running")
"        set t_Co=256
"        set term=xterm-256color
"        set term=rxvt-unicode-256color
"endif
"if exists("$TMUX")
"                "set t_Co=256
"                set notermguicolors
"else
"                set termguicolors
"endif


set exrc
" cursor is block all the time
" set guicursor=
" cursor is line in insert mode, else block (default)
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set relativenumber
set nu

set noerrorbells
set belloff=all

set nohlsearch
set hidden
set incsearch

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set clipboard=unnamed,unnamedplus

"auto-source vimrc when this file changes
augroup myvimrc
        au!
        au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"hi StatusLine guibg=white ctermfg=gray
set laststatus=2
set statusline=
set statusline+=%#LineNr#
set statusline+=\ %F

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"My command swaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "
let g:mapleader = " "

"centered movement
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap J <C-d>zz
nnoremap K <C-u>zz
map N Nzz
map n nzz
map G Gzz

"Cut, copy, paste
nnoremap Y y$
nnoremap x "_x
nnoremap <leader>d "_d
nnoremap <leader>D "_D
vnoremap <leader>d "_d
"map <leader>y "yy <Bar> :call system('xclip', @y)<CR>
"nnoremap <leader>p :r!xclip -out -selection primary<CR><CR>
"nnoremap <leader>v :r!xclip -out -selection clipboard<CR><CR>
map <leader>y "yy <Bar> :call system('wl-copy -p', @y)<CR>
nnoremap <leader>p :r!wl-paste -p<CR><CR>
nnoremap <leader>v :r!wl-paste<CR><CR>

" spelling next
nnoremap zn ]szz
nnoremap zN [szz

"Tab movement
nnoremap L gt
nnoremap H gT
noremap <S-Left>    :-tabmove<CR>
noremap <S-Right> :+tabmove<CR>

"Text alignment on equals
noremap <leader>a  :! column -t -s= -o=<CR>

"Text alignment on input char
command! -range -nargs=1 Align execute <line1>.",".<line2> . "! column -t -s<args> -o<args>"

" :S or :S! to searc across multiple lines/breaks
" Search for the ... arguments separated with whitespace (if no '!'),
" or with non-word characters (if '!' added to command).
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction
command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>

:command! RemoveQFItem :call RemoveQFItem()
" search for the current contents of your clipboard
noremap <C-s> :S <C-r>+<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Quickfix
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"quickfix movement
map <C-j> :cn<CR>
map <C-k> :cp<CR>
" open quickfix
nnoremap <leader>c :cw<CR>
" use C-t to open in new tab
augroup quickfix_tab | au!
        au filetype qf nnoremap <buffer> <C-t> <C-w><CR><C-w>T
augroup END
" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
    let curqfidx = line('.') - 1
    let qfall = getqflist()
    call remove(qfall, curqfidx)
    call setqflist(qfall, 'r')
    execute curqfidx + 1 . "cfirst"
    :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>

function!   QuickFixOpenAll()
    if empty(getqflist())
        return
    endif
    let s:prev_val = ""
    for d in getqflist()
        let s:curr_val = bufname(d.bufnr)
        if (s:curr_val != s:prev_val)
            exec "tabedit " . s:curr_val
        endif
        let s:prev_val = s:curr_val
    endfor
endfunction
:command! QuickFixOpenAll :call QuickFixOpenAll()
map <C-a> :QuickFixOpenAll<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Window commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 25 <CR>
nnoremap <silent> <leader>+ :vertical resize +5 <CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Latex helpers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPost,BufNewFile *.tex setfiletype=tex
augroup WrapLineInTeXFile
        autocmd!
        autocmd FileType tex setlocal wrap linebreak
        autocmd FileType tex setlocal textwidth=80
        autocmd FileType tex map j gj
        autocmd FileType tex map k gk
        autocmd FileType plaintex setlocal filetype=tex
        autocmd FileType plaintex setlocal wrap linebreak
        autocmd FileType plaintex setlocal textwidth=80
        autocmd FileType plaintex map j gj
        autocmd FileType plaintex map k gk
        "autocmd FileType tex setlocal syntax=tex
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin-specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>n :NvimTreeToggle<CR>
nnoremap <leader>N :NvimTreeFindFile<CR>

nnoremap <C-f> :Telescope git_files<CR>
nnoremap <leader>f :Telescope find_files<CR>
nnoremap <leader>s :Telescope live_grep<CR>
" nnoremap <silent> <leader>* :Telescope grep_string <C-R><C-W><CR>
nnoremap <expr> <leader>* ':Telescope grep_string<cr>' . "" . expand('<cword>')
nnoremap <expr> <leader>F ':Telescope find_files<cr>' . "" . expand('<cword>')
