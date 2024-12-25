.model small          ; Define memory model
.stack 100h           ; Define stack size
.data
    message db 'Hello, World!$' ; Define message string with '$' as the end marker

.code
main proc
    mov ax, @data     ; Load data segment address into AX
    mov ds, ax        ; Set DS to point to the data segment

    ; Print the message
    mov ah, 09h       ; Function 09h: Print string
    lea dx, message   ; Load address of the message into DX
    int 21h           ; Call DOS interrupt to print string

    ; Exit the program
    mov ah, 4Ch       ; Function 4Ch: Exit program
    int 21h           ; Call DOS interrupt to exit

main endp
end main
