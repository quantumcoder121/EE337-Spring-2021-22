; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

ORG 0000H
ljmp start

org 030h
start:
      mov P2,#00h
      mov P1,#00h
	  ;initial delay for lcd power up

	;here1:setb p1.0
      	  acall delay
	;clr p1.0
	  acall delay
	;sjmp here1


	  acall lcd_init      ;initialise LCD
	
	  acall delay
	  acall delay
	  acall delay
	  mov a,#81h		 ;Put cursor on first row,1 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  mov   dptr,#s0_1   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	   ;call text strings sending routine
	  acall delay
	  mov a,#0C1h		  ;Put cursor on second row,1 column
	  acall lcd_command
	  acall delay
	  mov   dptr,#s0_2
	  acall lcd_sendstring
	  mov P1, #0FFH
	  
	  acall DELAY_1S
	  
	  acall delay
	  acall delay
	  acall delay
	  acall lcd_init
	  mov a,#81h		 ;Put cursor on first row,1 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  mov   dptr,#s1_1   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	   ;call text strings sending routine
	  acall delay
	  mov a,#0C1h		  ;Put cursor on second row,1 column
	  acall lcd_command
	  acall delay
	  mov   dptr,#s0_2
	  acall lcd_sendstring
	  mov P1, #8FH
	  
	  acall DELAY_1S
	  acall DELAY_1S
	  
	  ;mov R3, #00h
	  mov a, P1
	  subb a, #80H
	  mov R3, a
	  mov P1, #4FH
	  
	  acall DELAY_1S
	  acall DELAY_1S
	  
	  ;mov R4, #01h
	  mov a, P1
	  subb a, #40H
	  mov R4, a
	  mov P1, #2FH
	  
	  
	  acall DELAY_1S
	  acall DELAY_1S
	  
	  ;mov R5, #00h
	  mov a, P1
	  subb a, #20H
	  mov R5, a
	  mov P1, #1FH
	  
	  
	  acall DELAY_1S
	  acall DELAY_1S
	  
	  ;mov R6, #02h
	  mov a, P1
	  subb a, #10H
	  mov R6, a
	  mov P1, #0FH
	  
	  mov a, R3
	  mov b, #10H
	  mul ab
	  add a, R4
	  mov 30H, a
	  
	  mov a, R5
	  mov b, #10H
	  mul ab
	  add a, R6
	  mov 31H, a
	  
	  mov a, 30H
	  mov b, 31H
	  mul ab
	  mov 50H, a
	  mov 51H, b
	  
	  acall delay
	  acall delay
	  acall delay
	  acall lcd_init
	  mov a,#81h		 ;Put cursor on first row,1 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  mov   dptr,#s5_1   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	   ;call text strings sending routine
	  acall delay
	  mov a,#0C1h		  ;Put cursor on second row,1 column
	  acall lcd_command
	  acall delay
	  mov   dptr,#s5_2   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	  ;call text strings sending routine
	  acall delay
	  mov a, 30h
	  mov R0, a
	  acall ASCII_CONV
	  mov a, 60H
	  acall lcd_senddata
	  acall delay
	  mov a, 61h
	  acall lcd_senddata
	  acall delay
	  
	  mov   dptr,#s5_3   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	  ;call text strings sending routine
	  acall delay
	  mov a, 31h
	  mov R0, a
	  acall ASCII_CONV
	  mov a, 60H
	  acall lcd_senddata
	  acall delay
	  mov a, 61h
	  acall lcd_senddata
	  acall delay
	  
	  acall DELAY_1S
	  acall DELAY_1S
	  
	  acall delay
	  acall delay
	  acall delay
	  acall lcd_init
	  
	  mov a,#81h		 ;Put cursor on first row,1 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  
	  mov   dptr,#s6_1   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	  ;call text strings sending routine
	  acall delay
	  
	  mov a, 51h
	  mov R0, a
	  acall ASCII_CONV
	  mov a, 60H
	  acall lcd_senddata
	  acall delay
	  mov a, 61h
	  acall lcd_senddata
	  acall delay
	  
	  mov a, 50h
	  mov R0, a
	  acall ASCII_CONV
	  mov a, 60H
	  acall lcd_senddata
	  acall delay
	  mov a, 61h
	  acall lcd_senddata
	  acall delay
	  
	  mov a,#0C1h		  ;Put cursor on second row,1 column
	  acall lcd_command
	  acall delay
	  
	  mov   dptr,#s5_2   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	  ;call text strings sending routine
	  acall delay
	  
	  mov a, 30h
	  mov R0, a
	  acall ASCII_CONV
	  mov a, 60H
	  acall lcd_senddata
	  acall delay
	  mov a, 61h
	  acall lcd_senddata
	  acall delay
	  
	  mov   dptr,#s5_3   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	  ;call text strings sending routine
	  acall delay
	  
	  mov a, 31h
	  mov R0, a
	  acall ASCII_CONV
	  mov a, 60H
	  acall lcd_senddata
	  acall delay
	  mov a, 61h
	  acall lcd_senddata
	  acall delay
	  




here: sjmp here				//stay here 

org 200h
;------------------------LCD Initialisation routine----------------------------------------------------
lcd_init:
         mov   LCD_data,#38H  ;Function set: 2 Line, 8-bit, 5x7 dots
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
	     acall delay

         mov   LCD_data,#0CH  ;Display on, Curson off
         clr   LCD_rs         ;Selected instruction register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay
         mov   LCD_data,#01H  ;Clear LCD
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay

         mov   LCD_data,#06H  ;Entry mode, auto increment with no shift
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en

		 acall delay
         
         ret                  ;Return from routine

;-----------------------command sending routine-------------------------------------
 lcd_command:
         mov   LCD_data,A     ;Move the command to LCD port
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
		 acall delay
    
         ret  
;-----------------------data sending routine-------------------------------------		     
 lcd_senddata:
         mov   LCD_data,A     ;Move the command to LCD port
         setb  LCD_rs         ;Selected data register
         clr   LCD_rw         ;We are writing
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         acall delay
		 acall delay
         ret                  ;Return from busy routine

;-----------------------text strings sending routine-------------------------------------
lcd_sendstring:
	push 0e0h
	lcd_sendstring_loop:
	 	 clr   a                 ;clear Accumulator for any previous data
	         movc  a,@a+dptr         ;load the first character in accumulator
	         jz    exit              ;go to exit if zero
	         acall lcd_senddata      ;send first char
	         inc   dptr              ;increment data pointer
	         sjmp  LCD_sendstring_loop    ;jump back to send the next character
exit:    pop 0e0h
         ret                     ;End of routine

;----------------------delay routine-----------------------------------------------------
delay:	 push 0
	 push 1
         mov r0,#1
loop2:	 mov r1,#255
	 loop1:	 djnz r1, loop1
	 djnz r0, loop2
	 pop 1
	 pop 0 
	 ret

;------------- ROM text strings---------------------------------------------------------------
org 300h
s0_1:
         DB   "Enter Inputs", 00H
s0_2:
		 DB   "EE337-2022", 00H
s1_1:
		 DB   "Reading Inputs", 00H
s5_1:
		 DB   "Computing Result", 00H
s5_2:
		 DB   "Num1:", 00H
s5_3:
		 DB   ",Num2:", 00H
s6_1:
		 DB   "Result = ", 00H





org 400h
DELAY_1S:
PUSH 00H
MOV R0, #5
H4: ACALL DELAY_200MS
DJNZ R0, H4
POP 00H
RET
DELAY_200MS:
PUSH 00H
MOV R0, #250
H3: ACALL DELAY_1MS
DJNZ R0, H3
POP 00H
RET
DELAY_1MS:
PUSH 00H
MOV R0, #4
H2: ACALL DELAY_250US
DJNZ R0, H2
POP 00H
RET
DELAY_250US:
PUSH 00H
MOV R0, #244
H1: DJNZ R0, H1
POP 00H
RET

ASCII_CONV:
MOV A, R0
MOV B, #10H
DIV AB
MOV R0, A
MOV R1, B
MOV A, #09H
CLR C
SUBB A, R0
JNC NCARRY1
MOV A, R0
ADD A, #37H
MOV 60H, A
LJMP CARRY1
NCARRY1:
MOV A, R0
ADD A, #30H
MOV 60H, A
CARRY1:
MOV A, #09H
CLR C
SUBB A, R1
JNC NCARRY2
MOV A, R1
ADD A, #37H
MOV 61H, A
LJMP CARRY2
NCARRY2:
MOV A, R1
ADD A, #30H
MOV 61H, A
CARRY2:
RET

end