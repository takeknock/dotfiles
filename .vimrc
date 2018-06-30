"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/takeknock/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/takeknock/.vim/dein')
  call dein#begin('/home/takeknock/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/takeknock/.vim/dein/repos/github.com/Shougo/dein.vim')

  let g:config_dir = expand('~/.vim/dein/userconfig')
  let g:toml = g:config_dir . '/plugins.toml'
  let g:lazy_toml = g:config_dir . '/plugins_lazy.toml'
  " Add or remove your plugins here:
  call dein#load_toml(g:toml, {'lazy':0})
  call dein#load_toml(g:lazy_toml, {'lazy':1})
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')


  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

autocmd BufNewFile,BufRead *.py nnoremap <C-e> :!python %

"End dein Scripts-------------------------
"
set number
set title
