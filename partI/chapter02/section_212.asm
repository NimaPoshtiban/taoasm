; Demonstrate packed data types
option casemap:none

nl     = 10         ; \n ascii code
NULL   = 0
maxLen = 256


                .const ;holds data values for read-only constants
ttlStr     byte 'section_2.12',          0
moPrompt   byte 'Enter current Month: ', 0
dayPrompt  byte 'Enter current day: ',   0
yearPrompt byte 'Enter current year '
           byte '(last 2 digits only): ', 0
           
packed  byte  'Packed data is %04x',nl,0

theDate byte 'The date is %02d/%02d/%02d'
        byte nl, 0
badDayStr byte 'Bad day value was entered '
          byte '(expected 1-31)', nl, 0
badMonthStr byte 'Bad month value was entered '
            byte '(expected 1-12)', nl, 0
badYearStr byte 'Bad year value was entered '
           byte '(expected 00-99)', nl, 0
           
                .data
month byte ?
day   byte ?
year  byte ?
date  word ?

input byte maxLen dup (?)

                .code
                externdef printf:proc
                externdef readLine:proc
                externdef atoi:proc
                
                public getTitle
getTitle proc
        lea rax, ttlStr
        ret 
getTitle endp

; int readNum(char *prompt);
; This procedure prints the prompt, reads an input string from the
; user, then converts the input string to an integer and returns the
; integer value in RAX.
readNum  proc
        sub rsp, 56 ; stack setup

        call printf
        
        lea  rcx, input
        mov  rdx, maxLen
        call readLine

        cmp rax, NULL
        je  badInput

        lea  rcx, input
        call atoi

badInput:
        add rsp, 56 ; undo stack setup
        ret
readNum endp


                public asmMain
asmMain proc
        sub rsp, 56

        lea  rcx, moPrompt
        call readNum

        cmp rax,   1
        jl  badMonth
        cmp rax,   12
        jg  badMonth
        mov month, al

        lea  rcx, dayPrompt
        call readNum

        cmp rax, 1
        jl  badDay
        cmp rax, 31
        jg  badDay
        mov day, al

        lea  rcx, yearPrompt
        call readNum

        cmp rax,  1
        jl  badYear
        cmp rax,  99
        jg  badYear
        mov year, al

        ; Pack the data into the following bits:
        ; 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
        ; m m m m d d d d d y y y y y y y
        movzx ax,   month ;0000_0000_0000_1100
        shl   ax,   5     ; -> 0000_0001_1000_0000
        or    al,   day   ; ->  0000_0000 OR 0001_1110 => 0000_0001_1001_1110
        shl   ax,   7     ; ->  1100_1111_0000_0000
        or    al,   year  ; -> 0000_0000 OR 0110_0011 -> 1100_1111_0110_0011
        mov   date, ax    ; 1100_1111_0110_0011

        lea   rcx, packed
        movzx rdx, date
        call  printf
        
        ; Unpack the date and print it:
        movzx rdx, date
        mov   r9,  rdx
        and   r9,  7fh  ; 1100_1111_0110_0011 AND 0111_1111 -> 0000_0000_0110_0011 =>(keep 7bits for the year)
        shr   rdx, 7    ; 0000_0001_1001_1110  =>  get day in position
        mov   r8,  rdx
        and   r8,  1fh  ; 1100_1111_0110_0011 AND 0001_1111 => 0000_0000_0000_0011 (month)
        shr   rdx, 5    ; 0000_0000_0000_1100 (get month in position)

        lea  rcx, theDate
        call printf

        jmp allDone

badDay:
        lea  rcx, badDayStr
        call printf
        jmp  allDone

badMonth:
        lea  rcx, badMonthStr
        call printf
        jmp  allDone
badYear:
        lea  rcx, badYearStr
        call printf
        jmp  allDone
allDone:
        add rsp, 56
        ret
asmMain endp


end