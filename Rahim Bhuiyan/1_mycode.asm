section .data
    prompt_desc db "Enter expense description: ", 0
    prompt_amt db "Enter amount: ", 0
    newline db 10, 0
    buffer db 0, 32 dup(0) ; Temporary buffer for input
    expenses db "Expenses: ", 0
    expense_entry db "", 1000 dup(0) ; Buffer for storing entries

section .bss
    desc resb 50       ; Reserve space for descriptions
    amount resb 10     ; Reserve space for amounts
    desc_offset resd 1 ; Offset tracker for descriptions
    amt_offset resd 1  ; Offset tracker for amounts

section .text
    global _start

_start:
    ; Loop for entry
    call input_description
    call input_amount

    ; Display all expenses
    call print_op_results ()
You sent
section .data
    prompt_desc db "Enter expense description: ", 0
    prompt_amt db "Enter amount: ", 0
    newline db 10, 0
    expense_entry db "Expenses:\n", 0
    buffer db 0, 32 dup(0) ; Temporary buffer for input

section .bss
    desc resb 50            ; Space for descriptions
    amount resb 10          ; Space for amounts
    entry_count resd 1      ; Count of stored entries

section .text
    global _start

_start:
    mov dword [entry_count], 0 ; Initialize entry counter

main_loop:
    ; Prompt for description
    call input_description

    ; Prompt for amount
    call input_amount

    ; Add newline after entry
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Increase entry counter
    mov eax, [entry_count]
    inc eax
    mov [entry_count], eax

    ; Ask if more entries are needed (simulate for now)
    cmp eax, 3               ; Allow 3 entries (for simplicity)
    jl main_loop

    ; Display all expenses
    call display_expenses

    ; Exit program
    call exit_program

input_description:
    ; Print description prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_desc
    mov edx, 26
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    lea ecx, desc
    mov edx, 50
    int 0x80
    ret

input_amount:
    ; Print amount prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_amt
    mov edx, 13
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    lea ecx, amount
    mov edx, 10
    int 0x80
    ret

display_expenses:
    ; Print header
    mov eax, 4
    mov ebx, 1
    mov ecx, expense_entry
    mov edx, 10
    int 0x80

    ; Display description and amount (simple loop)
    ret

exit_program:
    mov eax, 1      ; syscall: exit
    xor ebx, ebx    ; status: 0
    int 0x80
You sent
section .data
    prompt_income db "Enter total income: ", 0
    prompt_expense db "Enter total expenses: ", 0
    result_summary db "Summary: ", 10, 0
    result_income db "Total Income: ", 0
    result_expenses db "Total Expenses: ", 0
    result_savings db "Savings: ", 0
    newline db 10, 0
    buffer db 0, 32 dup(0) ; Temporary buffer for input

section .bss
    income resd 1         ; Space to store income
    expenses resd 1       ; Space to store expenses
    savings resd 1        ; Space to store calculated savings

section .text
    global _start

_start:
    ; Input total income
    call input_income

    ; Input total expenses
    call input_expenses

    ; Calculate savings = income - expenses
    mov eax, [income]
    sub eax, [expenses]
    mov [savings], eax

    ; Display the summary report
    call display_summary

    ; Exit program
    call exit_program

input_income:
    ; Prompt for total income
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_income
    mov edx, 21
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    lea ecx, buffer
    mov edx, 32
    int 0x80

    ; Convert input to integer and store in income
    call str_to_int
    mov [income], eax
    ret

input_expenses:
    ; Prompt for total expenses
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_expense
    mov edx, 22
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    lea ecx, buffer
    mov edx, 32
    int 0x80

    ; Convert input to integer and store in expenses
    call str_to_int
    mov [expenses], eax
    ret

display_summary:
    ; Print "Summary: "
    mov eax, 4
    mov ebx, 1
    mov ecx, result_summary
    mov edx, 10
    int 0x80

    ; Print total income
    mov eax, 4
    mov ebx, 1
    mov ecx, result_income
    mov edx, 14
    int 0x80
    mov eax, [income]
    call int_to_str
    call print_string

    ; Print total expenses
    mov eax, 4
    mov ebx, 1
    mov ecx, result_expenses
    mov edx, 16
    int 0x80
    mov eax, [expenses]
    call int_to_str
    call print_string

    ; Print savings
    mov eax, 4
    mov ebx, 1
    mov ecx, result_savings
    mov edx, 9
    int 0x80
    mov eax, [savings]
    call int_to_str
    call print_string

    ret

print_string:
    ; Print string stored in buffer
    mov eax, 4
    mov ebx, 1
    lea ecx, buffer
    mov edx, 32
    int 0x80
    ret

str_to_int:
    ; Convert ASCII string in buffer to integer
    xor eax, eax    ; Clear EAX (result)
    xor ebx, ebx    ; Clear EBX (digit)
    lea ecx, buffer ; Load address of buffer
convert_loop:
    mov bl, [ecx]   ; Load next character
    cmp bl, 10      ; Check for newline
    je done_convert ; Exit loop if newline
    sub bl, '0'     ; Convert ASCII to digit
    imul eax, eax, 10 ; Multiply current result by 10
    add eax, ebx    ; Add new digit
    inc ecx         ; Move to next character
    jmp convert_loop
done_convert:
    ret

int_to_str:
    ; Convert integer in EAX to ASCII string in buffer
    lea ecx, buffer + 31 ; Start at the end of the buffer
    mov byte [ecx], 0    ; Null-terminate string
convert_to_ascii:
    xor edx, edx         ; Clear remainder
    mov ebx, 10          ; Divisor
    div ebx              ; Divide EAX by 10
    add dl, '0'          ; Convert remainder to ASCII
    dec ecx              ; Move back in buffer
    mov [ecx], dl        ; Store ASCII character
    test eax, eax        ; Check if EAX is 0
    jnz convert_to_ascii ; Repeat if not 0
    ret

exit_program:
    mov eax, 1      ; syscall: exit
    xor ebx, ebx    ; status: 0
    int 0x80