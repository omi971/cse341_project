.MODEL SMALL 
.STACK 100H
.DATA

; --------------- Variables --------------- 

username db 'omi971'
PASSWORD DB '123'
LEN EQU ($-PASSWORD)  ; calculates the length of the password variable

w_msg db 10, 13, 'Welcome to CSE341 Lab Project$'
w2_msg db 10, 13, 'Personal Finance Tracker$'

user_msg db 'Please enter your username: $'
pass_msg db 'Please enter your password: $'

MSG1 DB 10,13,'ENTER YOUR PASSWORD: $'
MSG2 DB 10,13,'Logged in Successful...........!!$'
MSG3 DB 10,13,'INCORRECT PASSWORD!$'
NEW DB 10,13,'$'
INST DB 10 DUP(0)

feature_msg db 10, 13, "Please Select your feature by input$"
f_msg_1 db 10, 13, "Input 1 --> Add Income$"
f_msg_2 db 10, 13, "Input 2 --> Add Expence$"
f_msg_3 db 10, 13, "Input 3 --> View Report$"
f_msg_4 db 10, 13, "Input 4 --> View Detailed Transaction$"
f_msg_5 db 10, 13, "Input 5 --> Set Budget$"
f_msg_6 db 10, 13, "Input 6 --> Exit the program$"


f_msg_11 db 10, 13, " ****** Add Income Page ****** $" 
f_msg_12 db 10, 13, " ****** Add Expence Page ****** $" 
f_msg_13 db 10, 13, " ****** View Report Page ****** $" 
f_msg_14 db 10, 13, " ****** View Transaction Page ****** $" 
f_msg_15 db 10, 13, " ****** Set Budget Page ****** $" 
f_msg_16 db 10, 13, " ****** Exit Program Page ****** $" 

input_msg db 10, 13, "Input to Select features: $"
space db 10, 13,  " $"
exit_msg db 10, 13, "Exiting the program Successfully$"

; --------------- Variables --------------- 



.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX

; --------------- enter your code here --------------- 


;  Welcome messege
mov ah, 9
lea dx, w_msg
int 21h

lea dx, w2_msg
int 21h


; Login Screen
LEA DX,MSG1
MOV AH,09H
INT 21H
MOV SI,00


; --------------- Taking Username and password --------------- 
UP1:
    MOV AH, 08H ; taking the user input without showing in the terminal
    INT 21H
    CMP AL, 0DH
    JE if_enter  ; if user press enter

    ; else store the input to array
    MOV [INST+SI], AL ; storing one by one inputs to password array --> INST
    
    ; showing * for each of the input
    MOV DL,'*'
    MOV ah, 2
    INT 21h

    INC SI
    JMP UP1

if_enter:
    MOV BX,00
    MOV CX, LEN ; length of the pre-stored password

CHECK:
    MOV AL,[INST+BX]
    MOV DL,[PASSWORD+BX]
    CMP AL,DL ; comparing the user input with pre-stored password
    JNE FAIL
    INC BX
    LOOP CHECK

    ; Log In Successfull Message
    LEA DX,MSG2 
    MOV AH,09H
    INT 21H
    
    ; After Login Successful
    JMP features

FAIL:
    LEA DX,MSG3
    MOV AH,009H
    INT 21H
    jmp exit

features:
; Show all features selection messeges

mov ah, 9
lea dx, space
int 21h

mov ah, 9
lea dx, feature_msg
int 21h

lea dx, f_msg_1
int 21h

lea dx, f_msg_2
int 21h

lea dx, f_msg_3
int 21h

lea dx, f_msg_4
int 21h

lea dx, f_msg_5
int 21h

lea dx, f_msg_6
int 21h

mov ah, 9
lea dx, space
int 21h


; Taking the user input for feature selection
mov ah, 9
lea dx, input_msg
int 21h

mov ah, 1
int 21h
sub al, 30h
mov cl, al

; if user inputs 1 go to add income page
cmp cl, 1 
je feature1

cmp cl, 2
je feature2

cmp cl, 3
je feature3

cmp cl, 4
je feature4

cmp cl, 5
je feature5

cmp cl, 6 ; Exit page
je feature6

; --------------------------- Feature Selection Menus ---------------------------------


feature1: ; Add Income
    mov ah, 9
    lea dx, f_msg_11
    int 21h
    jmp exit

feature2: ; Add Expence
    mov ah, 9
    lea dx, f_msg_12
    int 21h
    jmp exit


feature3: ; View Report
    mov ah, 9
    lea dx, f_msg_13
    int 21h
    jmp exit


feature4: ; View Detailes Transaction
    mov ah, 9
    lea dx, f_msg_14
    int 21h
    jmp exit


feature5: ; Set Budget
    mov ah, 9
    lea dx, f_msg_15
    int 21h
    jmp exit


feature6: ; Exiting the program
    mov ah, 9
    lea dx, f_msg_16
    int 21h
    jmp exit
; --------------------------- Feature Selection Menus ---------------------------------


; ------------------ exit to DOS ------------------------
exit:
mov ah, 9
lea dx, exit_msg
int 21h

MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
