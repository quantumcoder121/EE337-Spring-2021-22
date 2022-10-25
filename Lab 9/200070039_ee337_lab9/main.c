/**********************************************************
EE337: ADC IC MCP3008 interfacing with pt-51
(1) Complete spi_init() function from spi.h 
(2) Uncomment LM35 interfacing code from main function
		Choose appropriate scaling factor for converting temperature 
		sensor reading sampled using ADC such that it will be in 
		degree Celsius and display it on the LCD)
***********************************************************/

#include <at89c5131.h>
#include "lcd.h"																				//Driver for interfacing lcd 
#include "mcp3008.h"																		//Driver for interfacing ADC ic MCP3008


char adc_ip_data_ascii[6]={0,0,0,0,0,'\0'};							//string array for saving ascii of input sample
code unsigned char display_msg1[]="Volt.: ";						//Display msg on 1st line of lcd
code unsigned char display_msg2[]=" mV";								//Display msg on 2nd line of lcd
unsigned char display_msg3[]={0,0,0,'.',0,' ',223,'C','\0'};//"xxx °C", Display msg on 2nd line of lcd
code unsigned char display_msg4[]="Temp.: ";						//Display msg on 2nd line of lcd


void main(void)
{
	int j=0;
	unsigned int adc_data=0;
	//float temperature;
	
	spi_init();																					
	adc_init();
  lcd_init();
	
	
	
	while(1)
	{
	 	unsigned int x;
		float temperature;
		temperature = 30.0;
		 
		x = adc(0);																					//Read analog value from 0th channel of ADC Ic MCP3008
		adc_data = (unsigned int) (x*3.2258); 							//Converting received 10 bits value to milli volt (3.3*1000*i/p /1023)
		
		lcd_cmd(0x80);																			//Move cursor to first line
		lcd_write_string(display_msg1);											//Display "Volt: " on first line of lcd
		
		int_to_string(adc_data,adc_ip_data_ascii);					//Converting integer to string of ascii
		
		lcd_write_string(adc_ip_data_ascii);								//Print analog sampled input on lcd
		lcd_write_string(display_msg2);											//Display "XXXXX mV"
		
		//LM35 Temperature sensor interfacing: Uncomment following code
	
	
		x = adc(7);																					//Read analog value from 7th channel of ADC Ic MCP3008
		
		
		//Use appropriate multiplier instead of 0.1 for converting it to degree Celsius
		
		temperature = (x*0.1*32.258); 															//NOTE: LM35 O/P: 10mV/°C, Refer to LM35 datasheet for more information
	

		
		x = (unsigned int) (temperature*10.0);							//Convert float value to unsigned int 
																												//Multiply with 10 to retain 0.1 deg C as a least count of temp
		int_to_string(x,adc_ip_data_ascii);									//Converting integer to string of ascii
		lcd_cmd(0xC0);																			//Move cursor to 2nd line of LCD
		lcd_write_string(display_msg4);
		display_msg3[0] = adc_ip_data_ascii[1];							//Convert temp ascii string to appropriate value 
		display_msg3[1] = adc_ip_data_ascii[2];
		display_msg3[2] = adc_ip_data_ascii[3];
		display_msg3[4] = adc_ip_data_ascii[4];
										 
		lcd_write_string(display_msg3);											//Print temperature sensed by sensor

	}
}

