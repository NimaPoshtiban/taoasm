; Demonstrate two's complement operation and input of numeric values.
option casemap:none
nl     = 10         ; ASCII code for newline
maxLen = 256
    .data

titleStr byte "section_3",                           0
prompt1  byte "Enter an integer between 0 and 127:", 0
fmtStr1 byte "Value in hexadecimal: %x", nl, 0
fmtStr2 byte "Invert all the bits (hexadecimal): %x", nl, 0
fmtStr3 byte "Add 1 (hexadecimal): %x", nl, 0
fmtStr4 byte "Output as signed integer: %d", nl, 0
fmtStr5 byte "Using neg instruction: %d", nl, 0

intValue sqword ?
input    byte maxLen dup (?)

    .code 
externdef printf:proc
externdef atoi:proc
externdef readLine:proc

    public getTitle
getTitle proc
    lea rax, titleStr
    ret
getTitle endp

    public asmMain
asmMain proc
    sub rsp, 56
    
    lea  rcx, prompt1
    call printf

    lea  rcx, input
    mov  rdx, maxLen
    call readLine

    lea  rcx,      input
    call atoi
    and  rax,      0ffh
    mov  intValue, rax

    lea  rcx, fmtStr1
    mov  rdx, rax
    call printf

    mov  rdx, intValue
    not  dl
    lea  rcx, fmtStr2
    call printf

; Invert all the bits and add 1 (still working with just a byte)
    mov  rdx, intValue
    not  rdx
    add  rdx, 1
    and  rdx, 0ffh
    lea  rcx, fmtStr3
    call printf
; Negate the value and print as a signed integer (work with a full
; integer here, because C++ %d format specifier expects a 32-bit
; integer). HO 32 bits of RDX get ignored by C++.
    mov  rdx, intValue
    not  rdx
    add  rdx, 1
    lea  rcx, fmtStr4
    call printf


    mov  rdx, intValue
    neg  rdx
    lea  rcx, fmtStr5
    call printf

    

    add rsp, 56
    ret
asmMain endp

end