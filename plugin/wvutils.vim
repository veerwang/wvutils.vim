" 通用库脚本库 
" Last Change:	2019.03.05 
" Maintainer:   kevin.wang kevin.wang2004@hotmail.com	
" License:	This file is placed in the public domain.

" 变量说明
"“$”——访问环境变量；
"“&”——访问 Vim 选项；
"“@”——访问寄存器。
"
"
"“b:”——只对当前缓冲区（buffer）有效的变量；
"“w:”——只对当前编辑窗口（window）有效的变量。
"“g:”——全局变量（在函数中访问全局变量必须使用该前缀，不加前缀的话则认为是函数内的局部变量）；
"“s:”——变量名只在当前脚本中有效；
"“a:”——函数的参数；
"“v:”——Vim 内部预定义的特殊变量（参见“:help vim-variable”）。

" 避免一个插件被加载多次
if exists('g:wvutils_exits') 
	finish
endif
let g:wvutils_exits = 1

" 避免一个插件被加载多次

" 在当前打开的文件下，写入一个字符串
" <SID> 的作用是使得函数生成一个唯一的ID数值
function! <SID>AddTextToFile(pos,astring)
	let failed = append(a:pos, a:astring)
	return
endfunction

function! <SID>SplitDraft()
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
		let failed = <SID>AddTextToFile(0,"<<----草稿纸---->>")
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

"
" Test 函数用于自己测试使用
function! <SID>Test()
	let s:mylist = ['monday','friday','sunday']
	call minifuctionsets#message(s:mylist,1)
	call add(s:mylist,'english')
	call minifuctionsets#message(s:mylist,1)

	let s:newlist = ['winter','autumn','sprint']
	call extend(s:newlist,['summer'])
	call minifuctionsets#message(s:newlist,1)

	" 打印每个list元素
	for n in s:newlist
		call minifuctionsets#message(n,1)
	endfor
	
endfunction

" 在popupmenu中显示内容
function! s:ListContain(contain)
	call complete(col('.'), a:contain)
	return ''
endfunc

" 查找:符号的函数
function! <SID>findflag()
	let s:linestr = getline(".")
	let maxlength = len(s:linestr)
	let s:flag = 0
	if maxlength == 0
		return s:flag
	endif
	let index = 1
	while index != maxlength
		let index = index + 1
		if s:linestr[index] == ':'
			let s:flag = s:flag + 1
		endif
	endwhile
	return s:flag
endfunction

" 显示日期
function! <SID>EnterDate()
	if &filetype == 'ledger'
		let s:date = strftime("%Y/%b/%d")
		let s:msg = input("输入抬头 ", s:date."      *")
		let failed = append(line('.') - 1,s:msg)
		return ''
	else
		return '/'
	endif
endfunction

" 将文件中的内容以pop的方式显示出来
function! <SID>ListAccount()
	let s:refpath = '/.vim/plugged/wvutils.vim/data/'
	let s:accountscripts = ['gaccount.vim','saccount.vim','ssaccount.vim','empty.vim']
	" &的定义描述见该文件头部
	" s:mflag 只有3级
	if &filetype == 'ledger'
		let s:mflag = <SID>findflag()
		if s:mflag > 4 
			let s:mflag = 4 
		endif
		let s:desfile = $HOME.s:refpath.s:accountscripts[s:mflag]
		let s:account=readfile(s:desfile,'')
		let s:newcontain = ['']
		let s:empty = ''

		if s:mflag < 2
			let s:empty = ':'
		endif

		for n in s:account
			call add(s:newcontain,n.s:empty)
		endfor

		call s:ListContain(s:newcontain)
  		return ''
	endif
	" 正常的非ledger文件格式的文件
	return ':'
endfunc

" 自定义命令,注意命令的首字母必须要大写
" :WvuFight <cr> 这样就能调用
command! -nargs=0 WvuFight  call minifuctionsets#message("祝你好运",1)
command! -nargs=0 WvuText   call <SID>AddTextToFile(0,"Hello")
command! -nargs=0 WvuDraft  call <SID>SplitDraft()
command! -nargs=0 WvuTest  call <SID>findflag()

" 在插入的状态下，键入:，并且如果是ledger文件类型
" 就能调用这个函数
inoremap : <C-R>=<SID>ListAccount()<CR>
inoremap / <C-R>=<SID>EnterDate()<CR>
