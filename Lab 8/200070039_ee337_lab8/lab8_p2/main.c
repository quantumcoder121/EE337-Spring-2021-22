#include <at89c5131.h>
#include "lcd.h"		//Header file with LCD interfacing functions
#include "serial.h"	//C file with UART interfacing functions

sbit LED=P1^7;

//Test function definitions

/************************************************
   lcd_test():
	LCD test function that gets called when
	'1' is received from UART
	Prints "LCD Ok" on LCD. After 4 seconds
	LCD is cleared
************************************************/
void lcd_test(void)
{
	 lcd_cmd(0x80);
	 lcd_write_string("LCD Ok");
	 msdelay(2000);
	 lcd_cmd(0x01);
}	

/************************************************
   led_test():
	LED test code. Update this function
	to test LEDs on P1.7-P1.4 by blinking
	them for a few times.
************************************************/
void led_test(void)
{
// Write your testing code here.	
	P1 = 0x10;
	msdelay(500);
	P1 = 0x20;
	msdelay(500);
	P1 = 0x40;
	msdelay(500);
	P1 = 0x80;
}


//Main function
void main(void)
{
	unsigned char ch=0;
	
	//Initialize port P1 for output from P1.7-P1.4
	P1 = 0x0F;
	
	//Call initialization functions
	lcd_init();
	uart_init();
	
	//These strings will be printed in terminal software
	transmit_string("************************\r\n");
	transmit_string("******8051 Tests********\r\n");
	transmit_string("************************\r\n");
	transmit_string("Press 1 for LCD test\r\n");
	transmit_string("Press 2 for LED test\r\n");
	
	while(1)
	{
			//Receive a character
			ch = receive_char();
		
			//Decide which test function to run based on character sent
      //Displays the string on the terminal software
			switch(ch)
			{
				case '1':lcd_test();
								 transmit_string("LCD tested\r\n");
								 break;
				
				case '2':led_test();
								 transmit_string("LED tested\r\n");
								 break;
							
				default:transmit_string("Incorrect test. Pass correct number\r\n");
								 break;
				
			}
			msdelay(100);
	}
}
