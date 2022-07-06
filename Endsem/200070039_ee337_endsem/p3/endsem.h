#include <at89c5131.h>
/*************************************************
 	endsem.h

    this header have all relevent functions fot this exam
    if you need any more function(s) you can make / use from previous labs.
	if you make new function(s) please define them in main.c
**************************************************/

bit tx_complete = 0,rx_complete = 0; //Bit flags for interrupts

void int_to_string(unsigned int,unsigned char *temp_string);
void int_to_string_2(unsigned int,unsigned char *temp_string);

/**********************************************************
   uart_init(): 
	Initialization function to be completed
	Initializes UART peripheral for 8-bit transfer, 
	1 start and 1 stop bits. 
	
	Please write TH1 value for required baud rate
***********************************************************/	
void uart_init(void)
{
	TMOD=0x20;			
	TH1=0xF3;			
	SCON=0x50;			 
	TR1 = 1;//			
	ES = 1;				
	EA = 1;				
	//Configure Timer 1 in Mode 2
			//Load TH1 to obtain require Baudrate (Refer Serial.pdf for calculations)
			//Configure UART peripheral for 8-bit data transfer 
			//Start Timer 1
	 		//Enable Serial Interrupt
			//Enable Global Interrupt
}


void int_to_string(unsigned int val,unsigned char *temp_str_data)
{	
   // char str_data[4]=0;
		temp_str_data[0]=48+(val/10000);
	  temp_str_data[1]=48+(val%10000/1000);
	  temp_str_data[2]=48+((val%1000)/100);
	  temp_str_data[3]=48+((val%100)/10);
	  temp_str_data[4]=48+(val%10);
   // return str_data;
}

void int_to_string_2(unsigned int val,unsigned char *temp_str_data)
{	
   // char str_data[4]=0;
	  temp_str_data[0]=48+((val%10)/10);
	  temp_str_data[1]=48+(val%10);
   // return str_data;
}


/**********************************************************
   transmit_char(<unsigned char ch>): 
	Transmits a character using UART
***********************************************************/	
void transmit_char(unsigned char ch)
{
	SBUF=ch;				//Load data in SBUF
	while(!tx_complete); 			//Wait for tx_complete flag (interrupt to complete)
	tx_complete = 0;		//Clear tx_complete flag 
}


/**********************************************************
   transmit_string(<String pointer>): 
	Transmit a string using UART
***********************************************************/	
void transmit_string(unsigned char *s)
{
	while(*s != 0)
	{
			transmit_char(*s++);
	}
}


/**********************************************************
   receive_char(): 
	Receives a character through UART. Returns a 
	character.
***********************************************************/		
unsigned char receive_char(void)
{
	unsigned char ch = 0;
	while(!rx_complete);				//Wait for rx_complete(interrupt to complete)
	rx_complete = 0;
	ch = SBUF;					//Read data from SBUF
	return ch;					//Return read character
}


/**********************************************************
   Serial_ISR(): 
	Interrupt service routine for UART interrupt.
	Determines whether it is a transmit or receive
	interrupt and raise corresponding flag.
	Transmit or receive functions (defined above) monitor
	for these flags to check if data transfer is done.
***********************************************************/	
void serial_ISR(void) interrupt 4
{
		if(TI==1)			//check whether TI is set
		{
			TI = 0;			//Clear TI flag
			tx_complete = 1;	//Set tx_complete flag indicating interrupt completion
		}
		else if(RI==1)			//check whether RI is set
		{
			RI = 0;			//Clear RI flag
			rx_complete = 1;	//Set rx_complete flag indicating interrupt completion
		}
}
