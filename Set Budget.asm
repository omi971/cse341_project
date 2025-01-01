; Setting Budget
MOV AH, 09h                 
LEA DX, prompt_budget       
INT 21h                     

MOV AH, 01h                 
INT 21h                   
SUB AL, '0'                 
MOV CL, AL                  

MOV AH, 09h
LEA DX, budget_set          
INT 21h
RET

prompt_budget DB 'Enter your budget: $', 0
budget_set DB 'Budget set successfully!', 0




