.MODEL SMALL
.STACK 100H
.DATA
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

    msg1 DB 10, 13, 'Income Array Results:$'
    msg2 DB 10, 13, 'Expense Array Results:$'

    sum_msg DB 10, 13, 'Sum: $'
    min_msg DB 10, 13, 'Min: $'
    max_msg DB 10, 13, 'Max: $'

.CODE
MAIN:
    ; Initialize DS
    MOV AX, @DATA
    MOV DS, AX

    ; Process Income Array
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
    LEA DX, msg1
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
    LEA DX, msg2
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
END MAIN
