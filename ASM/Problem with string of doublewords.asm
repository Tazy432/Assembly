bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;A string of doublewords s is given . Save in another string only the high bytes of the doubleword , ex: x=11223344 , 88990011 => d=33,00
    s dd 23458754h,98064788h,77777777h
    ls equ ($-s)/4
    d resb ls
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi,0
        mov edi,0
        mov ecx,ls
        repeta:
            mov eax,dword[s+edi]
            mov byte[d+esi],ah
            add edi,4
            add esi,1
        loop repeta
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
