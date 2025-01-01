.MODEL SMALL
 
.STACK 100H

.DATA
a db 1,2,3,4,5
b db 5 dup(?)

; Income and Expense arrays
income_array DW 12, 34, 56, 78, 90, 11, 22, 33, 44, 55
expense_array DW 15, 25, 35, 45, 55, 65, 75, 85, 95, 20

; Variables to store results
income_sum DW 0
income_min DW 0
income_max DW 0

expense_sum DW 0
expense_min DW 0
expense_max DW 0

f_msg_14 db 10, 13, " ****** View Transaction Page ****** $" 

msg1 DB 10, 13, 'Income Array Results:$'
msg2 DB 10, 13, 'Expense Array Results:$'

sum_msg DB 10, 13, 'Sum: $'
min_msg DB 10, 13, 'Min: $'
max_msg DB 10, 13, 'Max: $'


.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX

; enter your code here

; ------------------ Showing the page Welcome messege ------------------------
mov ah, 9
lea dx, f_msg_14
int 21h





;exit to DOS

MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
