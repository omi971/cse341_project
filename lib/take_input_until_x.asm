; This code will take the input as many time you want, 
; until user input space or ' ' in the input


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
repeat:
mov ah,1
int 21h
mov ah,2
mov dl,al
int 21h
cmp al,' '
jne repeat

;exit to DOS

MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
