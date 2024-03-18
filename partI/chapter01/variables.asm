.data
; variables go here
u8 byte -1 ; name type initial value
i8 sbyte 250 ; 250 is too large for signed integer but masm only cares about size
i16 sword ? ; ? set initial value as default
i32 sdword ?
i64 sqword ?
;zero terminated C/C++ string
strVarName byte 'String of characters',0
; defining constants
dataSize = 256 ; label = expression
.code 



myproc proc ; proc_name proc (defining a procedure aka function in C/C++)
  ret;
myproc endp ; proc_name endp (end of procedure)

main proc
  mov al,u8; mov instruction al = u8
  sub ax,dataSize; al= al - dataSize
  add ax,dataSize; al = al + dataSize
  lea rcx,strVarName; lea reg64, memory_var => rcx = &strVarName[0]
  call myproc ; calling a procedure
  
  ret ; returns to caller
main endp

end ; EOF delimiter
