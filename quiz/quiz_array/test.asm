.model small
.stack 100h
.data
    arr db 10, 20, 9, 45, 89, 1, 4   ; Array of 7 elements
    arrSize db 7                     ; Size of the array
    minVal db ?                      ; Variable to store minimum value
    maxVal db ?                      ; Variable to store maximum value

.code
start:
    mov ax, @data            ; Load data segment
    mov ds, ax               ; Set DS

    ; Initialize minVal and maxVal with the first element of the array
    mov al, arr              ; Load first element into AL
    mov minVal, al           ; Set it as the initial minimum value
    mov maxVal, al           ; Set it as the initial maximum value

    ; Initialize index and loop counter
    mov cl, arrSize          ; CL = size of the array
    mov si, 1                ; SI = 1 (start from the second element)

FindMinMax:
    mov al, arr[si]          ; Load the current element into AL

    ; Compare with minVal
    mov bl, minVal           ; Load current minVal into BL
    cmp al, bl               ; Compare current element with minVal
    jge SkipMin              ; If AL >= BL, skip updating minVal
    mov minVal, al           ; Update minVal

SkipMin:
    ; Compare with maxVal
    mov bl, maxVal           ; Load current maxVal into BL
    cmp al, bl               ; Compare current element with maxVal
    jle SkipMax              ; If AL <= BL, skip updating maxVal
    mov maxVal, al           ; Update maxVal

SkipMax:
    inc si                   ; Move to the next array element
    dec cl                   ; Decrement loop counter
    jnz FindMinMax           ; Repeat until CL = 0

    ; Program termination
    mov ah, 4Ch              ; DOS terminate program
    int 21h
end start