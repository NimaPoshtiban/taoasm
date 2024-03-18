option casemap:none

nl = 10 ; new line character ascii code 
maxLen = 256 ;Maximum string size + 1

.data
input byte maxLen dup (?)
titleStr byte 'section_14', 0
prompt byte 'Enter a string: ', 0
fmtStr byte "User entered: '%s'", nl, 0

.code 

externdef printf:proc
externdef readLine:proc

public getTitle
getTitle proc
  lea rax,titleStr 
  ret;
getTitle endp

public asmMain

asmMain proc
  sub rsp,56
  lea rcx,prompt
  call printf
  mov input,0
  lea rcx,input
  mov rdx,maxLen
  call readLine
  lea rcx,fmtStr
  lea rdx,input
  call printf
  add rsp,56
  ret
asmMain endp

end
