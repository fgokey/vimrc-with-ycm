" set the runtime path to include Vundle and initialize
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" My Plugins here:"

Plugin 'bling/vim-airline'
"let g:airline_powerline_fonts = 1"
set laststatus=2
set t_Co=256

Plugin 'scrooloose/nerdtree'
let mapleader=","
nmap <silent> <leader>ne :NERDTree<CR>
nmap <silent> <leader>nc :NERDTreeClose<CR>
"map <silent> <F3> :NERDTreeToggle<CR>"
Plugin 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = {
      \ 'dir':  'vendor/bundle/*\|vendor/cache/*\|public\|spec',
      \ 'file': '\v\.(exe|so|dll|swp|log|jpg|png|json)$',
    \ }

"自动注释插件
Plugin 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"vim-colors-solarized

"主题
"Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
syntax enable
set background=dark
colorscheme molokai 
let g:solarized_termcolors=256

Plugin 'majutsushi/tagbar'
"nmap <Leader>tb :TagbarToggle<CR>      "快捷键设置
let g:tagbar_ctags_bin='/usr/bin/ctags'          "ctags程序的路径
let g:tagbar_width=30                   "窗口宽度的设置
map <F3> :TagbarToggle<CR>
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()  "如果是c语言的程序的话，tagbar自动开启

Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'

"YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:syntastic_cpp_compiler = 'g++' "change the compiler to g++ to support c++11. 
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++' "set the options of g++ to suport c++11.
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
inoremap <c-o> <c-x><c-o>
let g:ycm_semantic_triggers = {
  \     'c' : ['->', '  ', '.', ' ', '(', '[', '&'],
  \     'cpp,objcpp' : ['->', '.', ' ', '(', '[', '&', '::'],
  \     'perl' : ['->', '::', ' '],
  \     'php' : ['->', '::', '.'],
  \     'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
  \     'ruby' : ['.', '::'],
  \     'lua' : ['.', ':']
  \ }

Plugin 'winmanager'
let g:winManagerWindowLayout="NERDTree|TagList"
let g:NERDTree_title="[NERDTree]"
function! NERDTree_Start()
    exec 'NERDTree'
endfunction
function! NERDTree_IsValid()
    return 1
endfunction
nmap <silent> <F2> :if IsWinManagerVisible() <BAR> WMToggle<CR> <BAR> else <BAR> WMToggle<CR>:q<CR> endif <CR><CR>

" All of your Plugins must be added before the following line"
call vundle#end()            " required"
filetype plugin indent on    " required"

set nu  "show line number"
set ts=4 "tab length is 4"
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set list listchars=tab:→\ ,trail:·
set hlsearch incsearch smartcase ignorecase
autocmd BufNewFile,BufRead *.json set filetype=javascript


nmap mm :call ChangeMouse()<cr>
function ChangeMouse()
    if &mouse == "a"
        set mouse-=a
    else
        let &mouse = "a"
    endif
endfunction

"vim 配置
"自动补全
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {<CR>}<ESC>O
"设置跳出自动补全的括号
func SkipPair()  
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'  
        return "\<ESC>la"  
    else  
        return "\tab"  
    endif  
endfunc  
" 将tab键绑定为跳出括号  
inoremap <TAB> <c-r>=SkipPair()<CR>
set nocompatible
set sw=4
set autoindent
set backspace=indent,eol,start
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

"定义函数SetTitle，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec":call SetTitle()"
func SetTitle() 
"如果文件类型为.sh文件
 if &filetype == 'sh' 
 call setline(1,"#!/bin/bash") 
 call append(line("."),"") 
 elseif &filetype == 'python'
 call setline(1,"#!/usr/bin/env python")
 call append(line("."),"# coding=utf-8")
 call append(line(".")+1,"") 

 elseif &filetype == 'ruby'
 call setline(1,"#!/usr/bin/env ruby")
 call append(line("."),"# encoding: utf-8")
 call append(line(".")+1,"")
else
 call setline(1,"/*************************************************************************") 
 call append(line("."),"> File Name     : ".expand("%")) 
 call append(line(".")+1,"> Author        : feiqiuping") 
 call append(line(".")+2,"> Mail          : feiqp@skyjoo.com") 
 call append(line(".")+3,"> Created Time  : ".strftime("%c")) 
 call append(line(".")+4,"************************************************************************/") 
 call append(line(".")+5,"")
endif
 if expand("%:e") == 'cpp'
 call append(line(".")+6,"#include<iostream>")
 call append(line(".")+7,"using namespace std;")
 call append(line(".")+8,"")
endif
 if &filetype == 'c'
 call append(line(".")+6,"#include<stdio.h>")
 call append(line(".")+7,"")
endif
 if expand("%:e") == 'h'
 call append(line(".")+6,"#ifndef _".toupper(expand("%:r"))."_H")
 call append(line(".")+7,"#define _".toupper(expand("%:r"))."_H")
 call append(line(".")+8,"#endif")
endif
 if &filetype == 'java'
 call append(line(".")+6,"public class".expand("%:r"))
 call append(line(".")+7,"")
endif
"新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G 
