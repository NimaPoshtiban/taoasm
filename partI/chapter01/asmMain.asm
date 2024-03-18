; a simple example that contains
; an empty function to be called 
; from C++ code 

.code 

option casemap:none ;make masm case-sensitive

public asmFunc

asmFunc PROC
  ret;
asmFunc ENDP

END
