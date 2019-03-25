" 使用python接口实现的通用库脚本库 
" Last Change:	2019.03.25 
" Maintainer:   kevin.wang kevin.wang2004@hotmail.com	
" License:	This file is placed in the public domain.

scriptencoding utf-8

function! pythonfunctionset#pythonprint(str)
python << EOF
import vim
print( "this is python module --> " + vim.eval("a:str") )
EOF
endfunction
