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

; ------------------------ Variables for View Transaction
; Define the Income and Expense arrays
income_array DW 12, 34, 56, 78, 90, 11, 22, 33, 44, 55
expense_array DW 15, 25, 35, 45, 55, 65, 75, 85, 95, 20

; Variables to store results
income_sum DW 0
income_min DW 0
income_max DW 0

expense_sum DW 0
expense_min DW 0
expense_max DW 0

i_msg DB 10, 13, 'Income Array Results:$'
e_msg DB 10, 13, 'Expense Array Results:$'

sum_msg DB 10, 13, 'Sum: $'
min_msg DB 10, 13, 'Min: $'
max_msg DB 10, 13, 'Max: $'
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


feature1: ; ------------------------------------------------------------ Add Income
    mov ah, 9
    lea dx, f_msg_11
    int 21h
    jmp exit

feature2: ; ------------------------------------------------------------  Add Expence
    mov ah, 9
    lea dx, f_msg_12
    int 21h
    jmp exit


feature3: ; ------------------------------------------------------------  View Report
    mov ah, 9
    lea dx, f_msg_13
    int 21h
    jmp exit

; ---------------------------------------- View Detailes Transaction ------------------------------------------------------------
feature4: 
    mov ah, 9
    lea dx, f_msg_14
    int 21h

    LEA SI, income_array  ; Point to income array
MOV CX, 10            ; Set array size
MOV AX, 0             ; Initialize sum
MOV BX, [SI]          ; Initialize min to the first element
MOV DX, [SI]          ; Initialize max to the first element

L1:
    MOV DI, [SI]          ; Get current element
    ADD AX, DI            ; Add to sum

    CMP DI, BX            ; Compare for min
    JL L1_SET_MIN
    JMP L1_NEXT_MIN

L1_SET_MIN:
    MOV BX, DI

L1_NEXT_MIN:
    CMP DI, DX            ; Compare for max
    JG L1_SET_MAX
    JMP L1_NEXT_MAX

L1_SET_MAX:
    MOV DX, DI

L1_NEXT_MAX:
    ADD SI, 2             ; Move to next element (2 bytes for a word)
    LOOP L1

    MOV [income_sum], AX  ; Store sum
    MOV [income_min], BX  ; Store min
    MOV [income_max], DX  ; Store max

    ; Process Expense Array
    LEA SI, expense_array ; Point to expense array
    MOV CX, 10            ; Set array size
    MOV AX, 0             ; Initialize sum
    MOV BX, [SI]          ; Initialize min to the first element
    MOV DX, [SI]          ; Initialize max to the first element

L2:
    MOV DI, [SI]          ; Get current element
    ADD AX, DI            ; Add to sum

    CMP DI, BX            ; Compare for min
    JL L2_SET_MIN
    JMP L2_NEXT_MIN

L2_SET_MIN:
    MOV BX, DI

L2_NEXT_MIN:
    CMP DI, DX            ; Compare for max
    JG L2_SET_MAX
    JMP L2_NEXT_MAX

L2_SET_MAX:
    MOV DX, DI

L2_NEXT_MAX:
    ADD SI, 2             ; Move to next element (2 bytes for a word)
    LOOP L2

    MOV [expense_sum], AX ; Store sum
    MOV [expense_min], BX ; Store min
    MOV [expense_max], DX ; Store max

    ; Display Results for Income Array
    LEA DX, i_msg
    MOV AH, 09H
    INT 21H

    LEA DX, sum_msg
    MOV AH, 09H
    INT 21H
    MOV AX, [income_sum]
    CALL PRINT_NUMBER

    LEA DX, min_msg
    MOV AH, 09H
    INT 21H
    MOV AX, [income_min]
    CALL PRINT_NUMBER

    LEA DX, max_msg
    MOV AH, 09H
    INT 21H
    MOV AX, [income_max]
    CALL PRINT_NUMBER

    ; Display Results for Expense Array
    LEA DX, e_msg
    MOV AH, 09H
    INT 21H

    LEA DX, sum_msg
    MOV AH, 09H
    INT 21H
    MOV AX, [expense_sum]
    CALL PRINT_NUMBER

    LEA DX, min_msg
    MOV AH, 09H
    INT 21H
    MOV AX, [expense_min]
    CALL PRINT_NUMBER

    LEA DX, max_msg
    MOV AH, 09H
    INT 21H
    MOV AX, [expense_max]
    CALL PRINT_NUMBER

    ; Exit Program
    MOV AH, 4CH
    INT 21H

; Inline logic to display numbers
PRINT_NUMBER:
    MOV BX, 10             ; Divider for decimal system
    XOR CX, CX             ; Clear CX to use as a counter

ConvertLoop:
    XOR DX, DX             ; Clear DX for DIV
    DIV BX                 ; Divide AX by 10
    PUSH DX                ; Store remainder (digit) on stack
    INC CX                 ; Increment counter
    CMP AX, 0              ; Repeat until AX is 0
    JNE ConvertLoop

PrintDigits:
    POP DX                 ; Get digit from stack
    ADD DL, '0'            ; Convert to ASCII
    MOV AH, 02H            ; DOS interrupt to print a character
    INT 21H
    LOOP PrintDigits       ; Repeat for all digits
    RET
    
    jmp exit
; ---------------------------------------- View Detailes Transaction ------------------------------------------------------------



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
