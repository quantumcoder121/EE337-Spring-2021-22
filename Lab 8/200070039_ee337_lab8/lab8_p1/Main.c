#include <at89c5131.h>
#include "lcd.h" // Header file with LCD interfacing functions
#include "MorseCode.h" // Header file for Morse Code

sbit LED=P1^7;

void main(void){

	lcd_init();
	
	P1_0 = 1;
	P1_1 = 1;
	P1_2 = 1;
	P1_3 = 1;
	P1_4 = 0;
	P1_5 = 0;
	P1_6 = 0;
	P1_7 = 0;
	
	if (P1_0 == 1) {
		lcd_init();
		lcd_write_string("A");
		morse_a();
		while (1 > 0){}
	}
	
	if (P1_1 == 1) {
		lcd_init();
		lcd_write_string("B");
		morse_b();
		while (1 > 0){}
	}
	
	if (P1_2 == 1) {
		lcd_init();
		lcd_write_string("C");
		morse_c();
		while (1 > 0){}
	}
	
	if (P1_3 == 1) {
		lcd_init();
		lcd_write_string("D");
		morse_d();
		while (1 > 0){}
	}
	
	lcd_init();
	lcd_write_string("E");
	morse_e();
	while (1 > 0){}

}