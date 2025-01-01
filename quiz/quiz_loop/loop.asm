.MODEL SMALL
 
.STACK 100H

.DATA
a db 1,2,3,4,5
b db 5 dup(?)

e_arr db 5 dup(?)
o_arr db 5 dup(?)
num db ?



.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX

; enter your code here
mov bh, 10 ; loop counter 10
mov bl, 2
mov si, 0


start:
mov ah, 1
int 21h
; mov dl, al ;input is in dl
sub al, 30h

cmp al, 0 ; if number == 0, then even
je if_zero

mov num, al
div bl
cmp ah, 0 ; if remainder == 0, then even
je evenn


cmp ah, 1 ; if remainder == 1, then odd
je odd

cmp bh, 0
je exit

if_zero:
mov cl, num
mov e_arr[si], cl
inc si
dec bh
jmp start

evenn:     
mov cl, num
mov e_arr[si], cl
inc si
dec bh
jmp start

odd:
mov cl, num     
mov o_arr[si], cl
inc si
dec bh
jmp start


;exit to DOS
exit:
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
