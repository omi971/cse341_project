.MODEL SMALL
 
.STACK 100H

.DATA
w_msg db "Welcome to CSE341 Lab Project$"
w2_msg db "Personal Finance Tracker$"

user_msg db "Please enter your username: $"
pass_msg db "Please enter your password: $"

wrong_user db "Wrong User Name"
wrong_pass db "Wrong Password"
pta_msg db "Please Try Again"


.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX

; enter your code here

; first welcome message
mov ah, 9
lea dx, w_msg
int 21h

; line feed and carrige return
mov ah, 2
mov dl, 0Dh
int 21h

mov ah, 2
mov dl, 0Ah
int 21h

; Second Welcome Message
mov ah, 9
lea dx, w2_msg
int 21h



;exit to DOS

MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
