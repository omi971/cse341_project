.MODEL SMALL
 
.STACK 100H

.DATA
; a db 1,2,3,4,5
a db 1,2,3,4,5

b db 5 dup(?)

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX

; enter your code here
mov cx,5
mov ah,2
mov si,0

start:
mov dl, a[si]
add dl, 30h
int 21h
add si,1
loop start

;exit to DOS

MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
