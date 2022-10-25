; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

ORG 0000H
ljmp start

org 200h
start:
      mov 89h, #01h
	  mov P2,#00h
      mov P1,#00h
	  mov TH0, #00H
	  MOV TL0, #00H
	  mov 60h, #00h
	  ;initial delay for lcd power up

	;here1:setb p1.0
      	  call delay
	;clr p1.0
	  call delay
	;sjmp here1


	  call lcd_init      ;initialise LCD
	
	  call delay
	  call delay
	  call delay
	  mov a,#83h		 ;Put cursor on first row,5 column
	  call lcd_command	 ;send command to LCD
	  call delay
	  mov   dptr,#toggle   ;Load DPTR with sring1 Addr
	  call lcd_sendstring	   ;call text strings sending routine
	  call delay

	  mov a,#0C2h		  ;Put cursor on second row,3 column
	  call lcd_command
	  call delay
	  mov   dptr,#led_glows
	  call lcd_sendstring
	  call delay
	  
	  mov P1, #0FFH
	  clr P1.4
	  clr P1.5
	  clr P1.6
	  clr P1.7
	  call DELAY_1S
	  call DELAY_1S
	  
	  setb P1.4
	  
	  setb TR0
	  here:
	  jnb P1.0, no_br
	  ljmp br
	  no_br:
	  jnb TF0, no_clock
	  inc 6Ah
	  mov TH0, #00h
	  mov TL0, #00h
	  setb TR0
	  no_clock:
	  LJMP here
	  br:
	  clr P1.4
	  mov 6Bh, TH0
	  mov 6Ch, TL0
	  
	  call lcd_init      ;initialise LCD
	
	  call delay
	  call delay
	  call delay
	  mov a,#82h		 ;Put cursor on first row,5 column
	  call lcd_command	 ;send command to LCD
	  call delay
	  mov   dptr,#rxn_time   ;Load DPTR with sring1 Addr
	  call lcd_sendstring	   ;call text strings sending routine
	  call delay

	  mov a,#0C0h		  ;Put cursor on second row,3 column
	  call lcd_command
	  call delay
	  mov   dptr,#count_is
	  call lcd_sendstring
	  call delay
	  
	  mov a, 6ah
	  mov 65h, a
	  call ASCII_CONV
	  mov a, 60h
	  call lcd_senddata
	  call delay
	  mov a, 61h
	  call lcd_senddata
	  call delay

	  mov   dptr,#spacebar
	  call lcd_sendstring
	  call delay

	  mov a, 6bh
	  mov 65h, a
	  call ASCII_CONV
	  mov a, 60h
	  call lcd_senddata
	  call delay
	  mov a, 61h
	  call lcd_senddata
	  call delay

	  mov a, 6ch
	  mov 65h, a
	  call ASCII_CONV
	  mov a, 60h
	  call lcd_senddata
	  call delay
	  mov a, 61h
	  call lcd_senddata
	  call delay

end_here: sjmp end_here
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
org 400h
toggle:
         DB   "Toggle SW1", 00H
led_glows:
		 DB   "if LED glows", 00H
rxn_time:
		 DB   "Reaction Time", 00H
count_is:
		 DB   "Count is ", 00H
spacebar:
		 DB   " ", 00H
	
org 600h
	
	DELAY_1S:
		MOV R7, #0C8H
		DELAY_1S_LOOP1:
			MOV TH0, #0D8H
			MOV TL0, #0F0H
			CLR TF0
			SETB TR0
			SR_HERE: 
				JNB TF0, SR_NO_BR
					LJMP SR_BR
				SR_NO_BR:
					SJMP SR_HERE
			SR_BR:
				DJNZ R7, DELAY_1S_LOOP1
		RET

ASCII_CONV:
MOV A, 65H
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