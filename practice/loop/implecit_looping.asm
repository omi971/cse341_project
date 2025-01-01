; implecit looping example code
; we use it like while loop

.MODEL SMALL
 
.STACK 100H

.DATA
a db 1,2,3,4,5
b db 5 dup(?)

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX

; enter your code here
mov dl, 30h

start:
cmp dl, 35h
jge exit
inc dl
mov ah, 2
int 21h
jmp start

;exit to DOS
exit:
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
