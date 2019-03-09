" 将一些通用的函数，进行整合 
" 注意放在autoload目录下的文件，可以被自动加载
" Last Change:	2019.03.09
" Maintainer:   kevin.wang kevin.wang2004@hotmail.com	
" License:	This file is placed in the public domain.

" 避免一个插件被加载多次
if exists('g:minifuctionsets_exits') 
	finish
endif
let g:minifuctionsets_exits = 1

function! minifuctionsets#version()
	return '1.0.0'
endfunction

" 进行字符串的显示，如果flag == 1,显示高亮
"                   如果flag == 0,普通显示
" !表示这个函数可以被安全的重载
function! minifuctionsets#message(arg,flag)
	if a:flag == 1
		echohl Title " 高亮以下内容 注意以下一定要a:打头，否者调用不到arg这个内部变量
	endif
	echo a:arg
	if a:flag == 1
		echohl None  " 结束高亮显示
	endif
	return
endfunction