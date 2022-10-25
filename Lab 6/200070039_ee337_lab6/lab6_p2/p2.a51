; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

ORG 0000H
ljmp start

org 200h
start:

	  MOV 89H, #01H
	  mov 70h, #23h
	  mov 71h, #45h
	  
	  clr c
	  mov a, 70h
	  mov b, #10h
	  div ab
	  mov 62h, b
	  mov 63h, a
	  clr c
	  mov a, 71h
	  mov b, #10h
	  div ab
	  mov 64h, b
	  mov 65h, a
	  mov b, #10h
	  mov a, 62h
	  mul ab
	  mov 62h, a
	  mov b, #10h
	  mov a, 63h
	  mul ab
	  mov 63h, a
	  mov b, #10h
	  mov a, 64h
	  mul ab
	  mov 64h, a
	  mov b, #10h
	  mov a, 65h
	  mul ab
	  mov 65h, a
	  
      mov P2,#00h
      mov P1,#00h
	  ;initial delay for lcd power up

	;here1:setb p1.0
      	  call delay
	;clr p1.0
	  call delay
	;sjmp here1


	  
MAIN_LOOP:
;-----------------------------------------------
	  call lcd_init      ;initialise LCD
	  call delay
	  call delay
	  call delay
	  
	  mov a,#85h		 ;Put cursor on first row,5 column
	  call lcd_command	 ;send command to LCD
	  call delay
	  mov   dptr,#lvl_1   ;Load DPTR with sring1 Addr
	  call lcd_sendstring	   ;call text strings sending routine
	  call delay

	  mov a,#0C3h		  ;Put cursor on second row,3 column
	  call lcd_command
	  call delay
	  mov   dptr,#val
	  call lcd_sendstring
	  call delay
	  
	  mov a, 62h
	  mov P1, a
	  mov b, #10h
	  div ab
	  
	  mov b, #08h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay

	  mov a, b
	  mov b, #04h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  mov a, b
	  mov b, #02h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  mov a, b
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  call DELAY_1S
;---------------------------------------------------

;-----------------------------------------------
	  call lcd_init      ;initialise LCD
	  call delay
	  call delay
	  call delay
	  
	  mov a,#85h		 ;Put cursor on first row,5 column
	  call lcd_command	 ;send command to LCD
	  call delay
	  mov   dptr,#lvl_2   ;Load DPTR with sring1 Addr
	  call lcd_sendstring	   ;call text strings sending routine
	  call delay

	  mov a,#0C3h		  ;Put cursor on second row,3 column
	  call lcd_command
	  call delay
	  mov   dptr,#val
	  call lcd_sendstring
	  call delay
	  
	  mov a, 63h
	  mov P1, a
	  mov b, #10h
	  div ab
	  
	  mov b, #08h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay

	  mov a, b
	  mov b, #04h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  mov a, b
	  mov b, #02h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  mov a, b
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  call DELAY_1S
;---------------------------------------------------

;-----------------------------------------------
	  call lcd_init      ;initialise LCD
	  call delay
	  call delay
	  call delay
	  
	  mov a,#85h		 ;Put cursor on first row,5 column
	  call lcd_command	 ;send command to LCD
	  call delay
	  mov   dptr,#lvl_3   ;Load DPTR with sring1 Addr
	  call lcd_sendstring	   ;call text strings sending routine
	  call delay

	  mov a,#0C3h		  ;Put cursor on second row,3 column
	  call lcd_command
	  call delay
	  mov   dptr,#val
	  call lcd_sendstring
	  call delay
	  
	  mov a, 64h
	  mov P1, a
	  mov b, #10h
	  div ab
	  
	  mov b, #08h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay

	  mov a, b
	  mov b, #04h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  mov a, b
	  mov b, #02h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  mov a, b
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  call DELAY_1S
;---------------------------------------------------

;-----------------------------------------------
	  call lcd_init      ;initialise LCD
	  call delay
	  call delay
	  call delay
	  
	  mov a,#85h		 ;Put cursor on first row,5 column
	  call lcd_command	 ;send command to LCD
	  call delay
	  mov   dptr,#lvl_4   ;Load DPTR with sring1 Addr
	  call lcd_sendstring	   ;call text strings sending routine
	  call delay

	  mov a,#0C3h		  ;Put cursor on second row,3 column
	  call lcd_command
	  call delay
	  mov   dptr,#val
	  call lcd_sendstring
	  call delay
	  
	  mov a, 65h
	  mov P1, a
	  mov b, #10h
	  div ab
	  
	  mov b, #08h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay

	  mov a, b
	  mov b, #04h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  mov a, b
	  mov b, #02h
	  div ab
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  mov a, b
	  add a, #30h
	  call lcd_senddata
	  call delay
	  
	  call DELAY_1S
;---------------------------------------------------
LJMP MAIN_LOOP				//stay here 

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
org 500h
lvl_1:
         DB   "Level 1", 00H
lvl_2:
		 DB   "Level 2", 00H
lvl_3:
         DB   "Level 3", 00H
lvl_4:
         DB   "Level 4", 00H
val:
		 DB   "Value:", 00H



org 600h
	
	DELAY_1S:
		MOV R7, #0C8H
		DELAY_1S_LOOP1:
			MOV TH0, #0D8H
			MOV TL0, #0F0H
			CLR TF0
			SETB TR0
			HERE: 
				JNB TF0, NO_BR
					LJMP BR
				NO_BR:
					SJMP HERE
			BR:
				DJNZ R7, DELAY_1S_LOOP1
		RET

end