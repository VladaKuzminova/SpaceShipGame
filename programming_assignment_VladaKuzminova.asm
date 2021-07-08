
include "emu8086.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DRAWING THE SHIP USING GRAPHICS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

MOV AH, 00h
MOV AL, 13h                 ;set graphics mode
INT 10h 


MOV AH, 0Ch
MOV AL, 14                  ;color of the pixel
MOV CX, 160                 ;horizontal position of the starting pixel
MOV DX, 95                  ;vertical position of the starting pixel
INT 10h 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LINE UP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
 
  MOV BL, 10                ;how many pixels to "draw"
     CALL UP                ;loop to draw a line up
     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DIAGONAL LINE TO THE LEFT DOWN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  
  MOV BL, 15                ;how many pixels to "draw"
    CALL LEFT_DOWN          ;loop to draw a diagonal line to the down-left
         
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DIAGONAL LINE TO THE RIGHT DOWN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
   MOV BL, 15               ;how many pixels to "draw"
    CALL RIGHT_DOWN         ;loop to draw a diagonal line to the down-right
         
         
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LINE UP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
   
   MOV BL, 10               ;how many pixels to "draw"
     CALL UP                ;loop to draw a line up
     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LINE TO THE RIGHT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
   
   MOV BL, 5                ;how many pixels to "draw"
     CALL RIGHT             ;loop to draw a line to the right
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LINE DOWN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                
   
   MOV BL, 10               ;how many pixels to "draw"
       CALL DOWN            ;loop to draw a line down
       
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DIAGONAL LINE TO THE RIGHT UP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
   
   MOV BL, 15               ;how many pixels to "draw"
       CALL RIGHT_UP        ;loop to draw a diagonal line to the right-up

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DIAGONAL LINE TO THE LEFT UP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                        
   
   MOV BL, 15               ;how many pixels to "draw"
    CALL LEFT_UP            ;loop to draw a diagonal line to the left-up
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LINE DOWN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
   
   MOV BL, 10               ;how many pixels to "draw"
    CALL DOWN               ;loop to draw a line down
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LINE TO THE LEFT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
   
   MOV BL, 5                ;how many pixels to "draw"
    CALL LEFT               ;loop to draw a line to the left
           
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DIAGONAL LINE TO THE LEFT DOWN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  
  MOV BL, 5                ;how many pixels to "draw"
    CALL LEFT_DOWN         ;loop to draw a diagonal line to the down-left
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DIAGONAL LINE TO THE RIGHT DOWN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
   MOV BL, 5               ;how many pixels to "draw"
    CALL RIGHT_DOWN        ;loop to draw a diagonal line to the down-right
         
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LINE TO THE RIGHT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
   
   MOV BL, 5                ;how many pixels to "draw"
    CALL RIGHT              ;loop to draw a line to the right
                   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DIAGONAL LINE TO THE RIGHT UP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
   
   MOV BL, 5               ;how many pixels to "draw"
    CALL RIGHT_UP          ;loop to draw a diagonal line to the right-up

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DIAGONAL LINE TO THE LEFT UP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                        
   
   MOV BL, 5               ;how many pixels to "draw"
    CALL LEFT_UP           ;loop to draw a diagonal line to the left-up


    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MAIN PART;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
   
loop_start:
    
    MOV DL, 0
    MOV DH, 0
    MOV AH, 2
    INT 10h
 
PRINTN "Enter 2(DOWN)" 
PRINTN "4(LEFT), 6(RIGHT)"
PRINTN "8(UP) or 0(EXIT)"   ;print message to the user

CALL SCAN_NUM               ;get a number
   

   CMP CX, 4                ;compare entered number 
        MOV DL, 15          ;column (vertical)
        MOV DH, 12          ;row (horizontal)
        MOV AH, 2           ;set the cursor position;
        INT 10h
   JE loop_left             ;perform the action(jump to label loop_left)
    
    
   CMP CX, 2                ;compare entered number
        MOV DL,  20         ;column (vertical)
        MOV DH,  15         ;row (horizontal)
        MOV AH,  2          ;set the cursor position;
        INT 10h 
   JE loop_down             ;perform the action(jump to label loop_down)
    
    
   CMP CX, 6                ;compare entered number
        MOV DL, 23          ;column (vertical)   
        MOV DH, 12          ;row (horizontal)
        MOV AH, 2           ;set the cursor position;
        INT 10h
   JE loop_right            ;perform the action(jump to label loop_right)
    
    
   CMP CX, 8                ;compare entered number
        MOV DL, 20          ;column (vertical)
        MOV DH, 9           ;row (horizontal)
        MOV AH, 2           ;set the cursor position;
        INT 10h 
   JE loop_up               ;perform the action(jump to label loop_up)
   
   
   CMP CX, 0                ;compare entered number 
        MOV DL, 35
        MOV DH, 23
        MOV AH, 2
        INT 10h
        PRINTN "BYE!"
   RET                      ;exit the program
RET 
                                
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ALL LABELS AND PROCEDURES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


loop_left:                  ;shoot laser to the left
    
    CALL bomb               ;call the procedure which prints the bomb
    CALL delete             ;call the procedure which erases the bomb
    CALL move_left          ;call the procedure which moves the bomb
    CALL bomb               ;call the procedure which prints the bomb
    CALL delete             ;call the procedure which erases the bomb

JNE loop_left 
JE loop_start 
RET

loop_right:                 ;shoot laser to the right
    
    CALL bomb               ;call the procedure which prints the bomb
    CALL delete             ;call the procedure which erases the bomb
    CALL move_right         ;call the procedure which moves the bomb
    CALL bomb               ;call the procedure which prints the bomb
    CALL delete             ;call the procedure which erases the bomb
    CMP DX,0C26h            ;terminate the loop when it reaches the end of the screen
JNE loop_right 
JE loop_start
RET

loop_up:                    ;shoot laser up
    
    CALL bomb               ;call the procedure which prints the bomb
    CALL delete             ;call the procedure which erases the bomb
    CALL move_up            ;call the procedure which moves the bomb
    CALL bomb               ;call the procedure which prints the bomb
    CALL delete             ;call the procedure which erases the bomb
JNE loop_up  
JE loop_start
RET

loop_down:                  ;shoot laser down
    
    CALL bomb               ;call the procedure which prints the bomb
    CALL delete             ;call the procedure which erases the bomb
    CALL move_down          ;call the procedure which moves the bomb
    CALL bomb               ;call the procedure which prints the bomb
    CALL delete             ;call the procedure which erases the bomb
    CMP DX, 1814h           ;terminate the loop when it reaches the end of the screen
JNE loop_down 
JE loop_start
RET 


bomb PROC                   ;print the bomb
       MOV AH, 09h          ;set printing mode
       MOV AL, '*'          ;characher
       MOV BL, 0x0C         ;color change
       MOV CX, 01h          ;how many times
       INT 10h              ;print
    RET      
bomb ENDP
    
    
delete PROC                 ;erase the bomb
        MOV BL  , 0x00      ;change to black
        INT 10h             ;print 
    RET     
delete ENDP
          
          
move_left PROC              ;move position to the left
        SUB DL, 1h          ;change position
        MOV AH, 2           ;set cursor 
        INT 10h  
    RET
move_left ENDP 
             
             
move_right PROC             ;move position to the right
        ADD DL, 1h          ;change position
        MOV AH, 2           ;set cursor 
        INT 10h  
    RET
move_right ENDP
    
    
move_up PROC                ;move position up
        SUB DH, 1h          ;change position
        MOV AH, 2           ;set cursor 
        INT 10h  
    RET
move_up ENDP
   
   
move_down PROC              ;move position down
        ADD DH, 1h          ;change position
        MOV AH, 2           ;set cursor 
        INT 10h  
    RET
move_down ENDP
 
 
      
UP PROC                     ;loop to draw a line up
      INT 10h
      DEC DX                ;by decreasing dx we draw line up
      DEC BL                 
      JNZ UP                ;if bl is not 0 we continue looping
RET
UP ENDP  


DOWN PROC
        INT 10h
        INC DX              ;by increasing dx we draw line down
        DEC BL
        JNZ DOWN            ;if bl is not 0 we continue looping
RET
DOWN ENDP  

LEFT_DOWN PROC              ;loop to draw a diagonal line to the down-left
        INT 10h
        INC DX              ;by increasing dx we draw line down
        DEC CX              ;by decreasing cx we draw diagonal line to the left
        DEC BL          
        JNZ LEFT_DOWN   
RET        
LEFT_DOWN ENDP 

LEFT_UP PROC
        INT 10h
        DEC CX              ;by decreasing cx we draw diagonal line to the left
        DEC DX              ;by decreasing dx we draw diagonal line up
        DEC BL
        JNZ LEFT_UP         ;if bl is not 0 we continue looping
RET
LEFT_UP ENDP   

RIGHT_DOWN PROC
        INT 10h             
        INC CX              ;by increasing cx we draw line to the right
        INC DX              ;by increasing dx we draw diagonal line down
        DEC BL
        JNZ RIGHT_DOWN      ;if bl is not 0 we continue looping
RET
RIGHT_DOWN ENDP 

RIGHT_UP PROC 
        INT 10h
        INC CX              ;by increasing cx we draw line to the right
        DEC DX              ;by decreasing dx we draw diagonal line up 
        DEC BL
        JNZ RIGHT_UP        ;if bl is not 0 we continue looping
RET
RIGHT_UP ENDP 

RIGHT PROC
        INT 10h
        INC CX              ;by increasing cx we draw line to the right
        DEC BL
        JNZ RIGHT           ;if bl is not 0 we continue looping     
RET
RIGHT ENDP

LEFT PROC
        INT 10h
        DEC CX              ;by decreasing cx we draw line to the left
        DEC BL
        JNZ LEFT            ;if bl is not 0 we continue looping
RET
LEFT ENDP

ERROR PROC
    MOV DL, 1
        MOV DH, 22
        MOV AH, 2
        INT 10h
    PRINTN "Please enter 2,"
    PRINTN " 4, 6, 8 or 0 only"    ;print message to the user
RET
ERROR ENDP

DEFINE_SCAN_NUM    