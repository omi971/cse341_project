.MODEL SMALL
.STACK 100H

.DATA
arr db 10, 20, 9, 45, 89, 1, 4
arrSize db 7
minVal db ?
maxVal db ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

; enter your code here

    MOV AL, arr
    MOV minVal, AL
    MOV maxVal, AL

    MOV CL, arrSize
    DEC CL
    MOV SI, 1

FindMinMax:
    MOV AL, arr[SI]
    MOV BL, minVal
    CMP AL, BL
    JGE SkipMin
    MOV minVal, AL

SkipMin:
    MOV BL, maxVal
    CMP AL, BL
    JLE SkipMax
    MOV maxVal, AL

SkipMax:
    INC SI
    DEC CL
    JNZ FindMinMax

;exit to DOS
    MOV AH, 4Ch
    INT 21h
    
    
MAIN ENDP
END MAIN
