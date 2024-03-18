option casemap:none

.data 

fmtStr byte 'Hello World!',10,0


.code


;calling external functions from C/C++
externdef printf:proc ; externdef symbol:type

public asmFunc
asmFunc proc
  sub rsp,56
  lea rcx,fmtStr
  call printf
  add rsp,56
  ret
asmFunc endp

end
