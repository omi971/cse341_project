; Adding Income
MOV AH, 09h                 
LEA DX, prompt_income      
INT 21h                    

MOV AH, 01h 
SUB AL, '0'                
MOV BL, AL                  

; Add income to existing balance
MOV AH, 09h
LEA DX, income_added        
INT 21h
RET

prompt_income DB 'Enter income: $', 0
income_added DB 'Income added successfully!', 0




