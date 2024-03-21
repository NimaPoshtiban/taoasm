nl        = 10             ; ascii code for new line

.data
i         qword 1
j         qword 123
k         qword 456789

titleStr  byte "section_1"
fmtStrI  byte "i=%d converted to hex=%x",nl,0
fmtStrJ  byte "j=%d converted to hex=%x",nl,0
fmtStrK  byte "k=%d converted to hex=%x",nl,0

.code 
externdef printf:proc

public    getTitle

getTitle  proc
    lea rax, titleStr
    ret

getTitle endp

public   asmMain
asmMain  proc
    sub  rsp, 56
    
    lea  rcx, fmtStrI
    mov  rdx, i
    mov  r8,  rdx
    call printf

    lea  rcx, fmtStrJ
    mov  rdx, j
    mov  r8,  rdx
    call printf

    lea  rcx, fmtStrK
    mov  rdx, k
    mov  r8,  rdx
    call printf

    add rsp, 56
    ret
asmMain endp

end