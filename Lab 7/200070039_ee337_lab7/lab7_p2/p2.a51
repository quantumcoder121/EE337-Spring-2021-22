; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

ORG 0000H
ljmp start

org 200h
start:

	  MOV 89H, #11H
      mov P2,#00h
      mov P1,#00h
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
	  mov a,#82h		 ;Put cursor on first row,5 column
	  call lcd_command	 ;send command to LCD
	  call delay
	  mov   dptr,#rolling_time   ;Load DPTR with sring1 Addr
	  call lcd_sendstring	   ;call text strings sending routine
	  call delay

main_routine_loop:

	  mov 60h, #0eeh
	  mov 61h, #40h
	  mov 62h, #52h
	  call PLAY_NOTE
	  
	  mov 60h, #0f0h
	  mov 61h, #30h
	  mov 62h, #52h
	  call PLAY_NOTE
	  
	  mov 60h, #0f2h
	  mov 61h, #0b8h
	  mov 62h, #52h
	  call PLAY_NOTE

	  mov 60h, #0f0h
	  mov 61h, #30h
	  mov 62h, #52h
	  call PLAY_NOTE

	  mov 60h, #0f5h
	  mov 61h, #72h
	  mov 62h, #6Fh
	  call PLAY_NOTE
	  
	  clr P0.7
	  mov 62h, #64h
	  MOV TH1, #0D8H
	  MOV TL1, #0F1H
	  CLR TF1
	  SETB TR1
	  silence_here: jnb TF1, silence_no_clock
	  djnz 62h, silence_no_br
	  ljmp silence_br
	  silence_no_br:
	  MOV TH1, #0D8H
	  MOV TL1, #0F1H
	  CLR TF1
	  SETB TR1
	  silence_no_clock:
	  ljmp silence_here
	  silence_br:

	  mov 60h, #0f5h
	  mov 61h, #72h
	  mov 62h, #6Fh
	  call PLAY_NOTE

	  mov 60h, #0f4h
	  mov 61h, #2bh
	  mov 62h, #6Fh
	  call PLAY_NOTE
	  
	  ljmp main_routine_loop

here: sjmp here				//stay here 

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
rolling_time:
         DB   "ROLLING TIME", 00H

ORG 500H
PLAY_NOTE:
MOV TH1, #0D8H
MOV TL1, #0F0H
CLR TF1
SETB TR1
SUBR_LOOP:
SETB P0.7
MOV TH0, 60H
MOV TL0, 61H
CLR TF0
SETB TR0
CALL CHECKER
CLR P0.7
MOV TH0, 60H
MOV TL0, 61H
CLR TF0
SETB TR0
CALL CHECKER
JNB TF1, NO_CLOCK
DJNZ 62H, NO_BR_2
LJMP BR_2
NO_BR_2:
MOV TH1, #0D8H
MOV TL1, #0F1H
CLR TF1
SETB TR1
NO_CLOCK:
LJMP SUBR_LOOP
BR_2:
RET
CHECKER:
SUBROUTINE_HERE: JNB TF0, NO_BR
LJMP BR
NO_BR: SJMP SUBROUTINE_HERE
BR: RET
END