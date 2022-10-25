// lcd.h: Header file for 16x2 LCD interfacing  

// Functions contained in this header file

void msdelay(unsigned int); // Takes integer value as an input and generates corresponding delay in miliseconds
void lcd_init(void); // Initializes LCD
void lcd_cmd(unsigned int i); // Sends commands to lcd
void lcd_char(unsigned char ch); // Displays character on a lcd corresponding to ASCII input
void lcd_write_string(unsigned char *s); // Takes pointer of a string which ends with null and display on a lcd
void int_to_string(unsigned int,unsigned char *temp_string); // Converts unsigned int to string of corresponding decimal value

sbit RS=P0^0; // Register select
sbit RW=P0^1; // Read from or write to register
sbit EN=P0^2; // Enable pin of lcd

//Function definitions

void lcd_init(void){

	P2=0x00;
	EN=0;
	RS=0;
	RW=0;
	
	lcd_cmd(0x38); // Function set: 2 Line, 8-bit, 5x7 dots
	msdelay(4);
	lcd_cmd(0x06); // Entry mode, auto increment with no shift
	msdelay(4);
	lcd_cmd(0x0C); // Display on, Cursor off
	msdelay(4);
	lcd_cmd(0x01); // Clears LCD
	msdelay(4);
	lcd_cmd(0x80); // Moves cursor to Row 1 column 0

}

void msdelay(unsigned int time){
	int i,j;
	for(i=0;i<time;i++){
		for(j=0;j<382;j++);
	}
}

void lcd_cmd(unsigned int i){
	RS=0;
	RW=0;
	EN=1;
	P2=i;
	msdelay(10);
	EN=0;
}


void lcd_write_char(unsigned char ch){
	RS=1;
	RW=0;
	EN=1;
	P2=ch;
	msdelay(10);
	EN=0;
}

void lcd_write_string(unsigned char *s){
	while(*s!='\0'){
		lcd_write_char(*s++);
	}
}