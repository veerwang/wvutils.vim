" 通用库脚本库 
" Last Change:	2019.03.05 
" Maintainer:   kevin.wang kevin.wang2004@hotmail.com	
" License:	This file is placed in the public domain.

" 避免一个插件被加载多次
if exists('g:wvutils_exits') 
	finish
endif
let g:wvutils_exits = 1
" 避免一个插件被加载多次

function! s:AddTextToFile()
	let failed = append(3, "the beginning")
	return
endfunction

function! s:SplitDraft()
	if !exists('g:wvu_draftpath')
		let g:wvu_draftpath = '/home/kevin/.vim/__DRAFT__'
	endif
	let s:fileexist = 0
	if filereadable(g:wvu_draftpath) 
		let s:fileexist = 1
	endif

	if s:fileexist == 1
		"是否重新创建新草稿纸
		let s:load_oldpaper=confirm("是否载入旧草稿纸?","&Yes\n&No",2)
		if s:load_oldpaper == 2
			let s:fileexist = 0
			call delete(g:wvu_draftpath)
		endif
	endif

	silent! execute 'vertical ' . '35 ' . 'split ' . g:wvu_draftpath
	if s:fileexist == 0
		let failed = append(0, "<<----草稿纸---->>")
	endif
	return
endfunction

"call minifuctionsets#version("-- 欢迎进入vim世界 --",1)

let s:wvutils_version = 'v1.0.1'
if !exists('s:wvutils_version')
	let s:wvutils_version = 'v1.0.0(init)'
endif
"call minifuctionsets#version("wvutils plugins version: ".s:wvutils_version,0)

" 休眠时间，以毫秒计算
"sleep 40m

" 得到一个临时文件的名称
"let s:tmpfile = tempname()
"call minifuctionsets#version('生产一个临时文件：'.s:tmpfile,0)

"　输入字符串
"let s:inputmsg = input('输入想要保存的内容: ')
"try
"	call writefile([s:inputmsg],s:tmpfile,'a')
"	call minifuctionsets#version('写入临时文件：'.s:tmpfile.' 成功',0)
"catch
"	echo '写入文件 ' . s:tmpfile . ' 失败!'
"endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 对外提供的接口函数
" 注意此处的定义方式
"call wvutils#welcome()
function! g:wvutils#welcome()
	call minifuctionsets#message("当前wvutils模块的版本:".s:wvutils_version,1)
endfunction
function! g:wvutils#version()
	return	s:wvutils_version
endfunction

" 自定义命令,注意命令的首字母必须要大写
" :WvuFight <cr> 这样就能调用
command! -nargs=0 WvuFight  call minifuctionsets#message("祝你好运",1)
command! -nargs=0 WvuText   call s:AddTextToFile()
command! -nargs=0 WvuDraft  call s:SplitDraft()
