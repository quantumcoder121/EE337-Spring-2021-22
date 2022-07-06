#include <at89c5131.h>
#include "endsem.h"

char S_str[6]= {0,0,0,0,0,0};   //String for Balance Sita
char G_str[6] = {0,0,0,0,0,0};  //String for Balance Gita
int s_bal = 10000;
int g_bal = 10000;
char n500_s[3]= {0,0,0};    // STRING FOR 500RS NOTE
char n100_s[3]= {0,0,0};    // STRING FOR 100RS NOTE

char password[5] = {0,0,0,0,0} ;   //PASSWORD ARRAY
//Main function

//-------------------------------------------------

void main(void)
{
	unsigned char ch = 0;
	unsigned char chac = 0;
	unsigned char ch1 = 0;
	unsigned char ch2 = 0;
	unsigned char cha = 0;
	unsigned char chb = 0;
	unsigned char chc = 0;
	unsigned char chd = 0;
	unsigned char che = 0;
	int num = 0;
	int num_five = 0;
	int num_one = 0;
	uart_init();    	// Please finish this function in endsem.h
  int_to_string(s_bal, S_str);
  int_to_string(g_bal, G_str);	
    while (1)
    {
        /* code */
        // YOUR CODE GOES HERE
			// initial state
			transmit_string("Press A for Account display and W for withdrawing cash\r\n");
			
			ch = receive_char();
			
			if (ch == 'A' || ch == 'a'){

				transmit_string("Hello, Please enter Account Number\r\n");
				
				chac = receive_char();
			
				if (chac == '1'){
					
					transmit_string("Please enter password\r\n");
					
					cha = receive_char();
					chb = receive_char();
					chc = receive_char();
					chd = receive_char();
					che = receive_char();
					if (cha != 'e' || chb != 'e' || chc != '3' || chd != '3' || che != '7') {
						transmit_string("Please enter correct password\r\n");
						continue;
					}
					transmit_string("Account Holder: Sita\r\n");
					transmit_string("Account Balance: ");
					transmit_string(S_str);
					transmit_string("\r\n");
				}

				else if (chac == '2'){
					transmit_string("Please enter password\r\n");
					
					cha = receive_char();
					chb = receive_char();
					chc = receive_char();
					chd = receive_char();
					che = receive_char();
					if (cha != 'u' || chb != 'p' || chc != 'l' || chd != 'a' || che != 'b') {
						transmit_string("Please enter correct password\r\n");
						continue;
					}
					transmit_string("Account Holder: Gita\r\n");
					transmit_string("Account Balance: ");
					transmit_string(G_str);
					transmit_string("\r\n");
				}

				else {
					transmit_string("No such account, please enter valid details\r\n");
				}

				continue;
			}

			if (ch == 'W' || ch == 'w'){

				transmit_string("Withdraw state, enter Account Number\r\n");
				
				chac = receive_char();
				
				num = 0;
			
				if (chac == '1' || chac == '2'){
					
					if (chac == '1'){
					transmit_string("Please enter password\r\n");
					
					cha = receive_char();
					chb = receive_char();
					chc = receive_char();
					chd = receive_char();
					che = receive_char();
					if (cha != 'e' || chb != 'e' || chc != '3' || chd != '3' || che != '7') {
						transmit_string("Please enter correct password");
						continue;
					}
				}
					else{
					transmit_string("Please enter password");
					
					cha = receive_char();
					chb = receive_char();
					chc = receive_char();
					chd = receive_char();
					che = receive_char();
					if (cha != 'u' || chb != 'p' || chc != 'l' || chd != 'a' || che != 'b') {
						transmit_string("Please enter correct password");
						continue;
					}
				}
					transmit_string("Enter amount, in hundreds\r\n");
					
						ch1 = receive_char();
					
						ch2 = receive_char();
					
					
					if (ch1 == '0') {
						num = num + 10 * 0;
					}
					else if (ch1 == '1') {
						num = num + 10 * 1;
					}
					else if (ch1 == '2') {
						num = num + 10 * 2;
					}
					else if (ch1 == '3') {
						num = num + 10 * 3;
					}
					else if (ch1 == '4') {
						num = num + 10 * 4;
					}
					else if (ch1 == '5') {
						num = num + 10 * 5;
					}
					else if (ch1 == '6') {
						num = num + 10 * 6;
					}
					else if (ch1 == '7') {
						num = num + 10 * 7;
					}
					else if (ch1 == '8') {
						num = num + 10 * 8;
					}
					else if (ch1 == '9') {
						num = num + 10 * 9;
					}
					else {
						transmit_string("Invalid Amount\r\n");
					}
					
					if (ch2 == '0') {
						num = num + 0;
					}
					else if (ch2 == '1') {
						num = num + 1;
					}
					else if (ch2 == '2') {
						num = num + 2;
					}
					else if (ch2 == '3') {
						num = num + 3;
					}
					else if (ch2 == '4') {
						num = num + 4;
					}
					else if (ch2 == '5') {
						num = num + 5;
					}
					else if (ch2 == '6') {
						num = num + 6;
					}
					else if (ch2 == '7') {
						num = num + 7;
					}
					else if (ch2 == '8') {
						num = num + 8;
					}
					else if (ch2 == '9') {
						num = num + 9;
					}
					else {
						transmit_string("Invalid Amount\r\n");
					}
					
					num = num * 100;
					
					if (chac == '1') {
						if (s_bal < num) {
							transmit_string("Insufficient Funds\r\n");
						}
						else {
							s_bal = s_bal - num;
							int_to_string(s_bal, S_str);
							num_five = num / 500;
							num_one = (num % 500) / 100;
							int_to_string_2(num_one, n100_s);
							int_to_string_2(num_five, n500_s);
							transmit_string("Remaining Balance: ");
							transmit_string(S_str);
							transmit_string("\r\n");
							transmit_string("500 Notes: ");
							transmit_string(n500_s);
							transmit_string(", 100 Notes: ");
							transmit_string(n100_s);
							transmit_string("\r\n");
						}
					}

					else {
						if (g_bal < num) {
							transmit_string("Insufficient Funds\r\n");
						}
						else {
							g_bal = g_bal - num;
							int_to_string(g_bal, G_str);
							num_five = num / 500;
							num_one = (num % 500) / 100;
							int_to_string_2(num_one, n100_s);
							int_to_string_2(num_five, n500_s);
							transmit_string("Remaining Balance: ");
							transmit_string(G_str);
							transmit_string("\r\n");
							transmit_string("500 Notes: ");
							transmit_string(n500_s);
							transmit_string(", 100 Notes: ");
							transmit_string(n100_s);
							transmit_string("\r\n");
						}
					}	

				}

				else {
					transmit_string("No such account, please enter valid details");
				}

				continue;
			}
			
    }
}


