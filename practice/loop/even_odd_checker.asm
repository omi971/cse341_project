.MODEL SMALL
 
.STACK 100H

.DATA
a db 1,2,3,4,5
b db 5 dup(?)


dividend db ?
msg db "Please enter the number you want to check: $"
e_msg db "The number is even$"
o_msg db "The number is odd$"
zero_msg db "The number is Zero.!$"

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX

; enter your code here

; taking input number from the user
mov ah, 9
lea dx, msg
int 21H

mov ah, 1
int 21h

sub al, 30h
mov dividend, al
; now dl holds the input value

; if input number is zero
mov al, dividend
cmp al, 0
je zero

mov bl, 2
div bl

cmp ah, 0
je evenn

cmp ah, 1
je odd


zero:
mov ah, 9

mov dl, 0Ah
int 21h
mov dl, 0Dh
int 21h

lea dx, zero_msg
int 21h
jmp exit


evenn:
mov ah, 9

mov dl, 0Ah
int 21h
mov dl, 0Dh
int 21h

lea dx, e_msg
int 21h
jmp exit


odd:
mov ah, 9

mov dl, 0Ah
int 21h
mov dl, 0Dh
int 21h

lea dx, o_msg
int 21h
jmp exit

;exit to DOS
exit:
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
