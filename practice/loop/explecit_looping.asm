; This is explecit looping example code
; we use it like for loop

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

mov cx,5 ;the bound will be in cx. (the number oftimes the loop will run)

mov dl,31h
mov ah,2

start:
int 21h
inc dl
loop start

;exit to DOS

MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
