/*
 * based on:
 *
 * WiFly Autoconnect Example
 * Copyright (c) 2010 SparkFun Electronics.  All right reserved.
 * Written by Chris Taylor
 *
 * This code was written to demonstrate the WiFly Shield from SparkFun Electronics
 * 
 * This code will initialise and test the SC16IS750 UART-SPI bridge, and automatically
 * connect to a WiFi network using the parameters given in the global variables.
 *
 * http://www.sparkfun.com
 */

#include "WiFly.h"
#include "Credentials.h"


void setup() {

	Serial.begin(9600);
	Serial.println("\n\r\n\rWiFly Shield Terminal Routine");

	WiFly.begin();

	//  SpiSerial.print("set ip protocol 0\r\n");

	if (!WiFly.join(ssid, passphrase)) {
		Serial.println("Association failed.");
		while (1) {
			// Hang on failure.
		}
	}
	Serial.println("Associated!");
	SpiSerial.print("$$$\r\n");
	delay(1000);
	SpiSerial.print("show net\r\n");
	SpiSerial.print("get ip\r\n");
	for(int i=0;i<1000;i++) {
		if(SpiSerial.available() > 0 ) { 
			Serial.print((char)SpiSerial.read());
			delay(100);
		}
	}

	SpiSerial.print("set ip protocol 1\r\n");
	SpiSerial.print("set ip host 192.168.1.100\r\n");
	SpiSerial.print("set remote port 1234\r\n");
	SpiSerial.print("save\r\n");
	SpiSerial.print("reboot\r\n");

	SpiSerial.print("$$$\r\n");
	SpiSerial.print("show net\r\n");
	SpiSerial.print("get ip\r\n");
	for(int i=0;i<1000;i++) {
		if(SpiSerial.available() > 0 ) { 
			Serial.print((char)SpiSerial.read());
			delay(100);
		}
	}
	SpiSerial.print("exit\r\n");
	delay(1000);
}


void loop() {
	// Terminal routine

	// Always display a response uninterrupted by typing
	// but note that this makes the terminal unresponsive
	// while a response is being received.
//	while(SpiSerial.available() > 0) {
//		Serial.print((char)SpiSerial.read());
//	}
//
//	if(Serial.available()) { // Outgoing data
//		SpiSerial.print((char)Serial.read());
//	}
SpiSerial.print("hello\n\n");
delay(1000);
}

