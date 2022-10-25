// MorseCode.h : Header file for Morse Code

// Functions contained in this header file

void dashtone(void);
void dottone(void);

void morse_a(void);
void morse_b(void);
void morse_c(void);
void morse_d(void);
void morse_e(void);

// Function definitions

void dashtone(void){ 
	unsigned i;
	for(i=0; i < 1500; i++){
		P0_7 = ~P0_7;
		msdelay(1);
	}
}

void dottone(void){
	unsigned i;
	for(i=0; i < 750; i++){
		P0_7 = ~P0_7;
		msdelay(1);
	}
}

void morse_a(void){
	dottone();
	msdelay(1000);
	dashtone();
	msdelay(1000);
}

void morse_b(void){
	dashtone();
	msdelay(1000);
	dottone();
	msdelay(1000);
	dottone();
	msdelay(1000);
	dottone();
	msdelay(1000);
}

void morse_c(void){
	dashtone();
	msdelay(1000);
	dottone();
	msdelay(1000);
	dashtone();
	msdelay(1000);
	dottone();
	msdelay(1000);
}

void morse_d(void){
	dashtone();
	msdelay(1000);
	dottone();
	msdelay(1000);
	dottone();
	msdelay(1000);
}

void morse_e(void){
	dottone();
	msdelay(1000);
}