#include "WiFly.h"
#include "Credentials.h"
extern void reset_now();

void setup() {

    Serial.begin(9600);
    Serial.println("\n\r\n\rWiFly Shield UDP blaster ");

    reset_now();

    WiFly.begin();

    if (!WiFly.join(ssid, passphrase)) {
        Serial.println("Association failed.");
        while (1) {
            // Hang on failure.
        }
    }
    Serial.println("Associated!");
    SpiSerial.print("get ip\r\n");
    delay(1000);
    while(SpiSerial.available() > 0) {
        Serial.print((char)SpiSerial.read());
    }


    SpiSerial.print("set ip proto 1\r\n"); // enter UDP mode
    delay(100);
    SpiSerial.print("set ip host 10.10.50.94\r\n"); // udp destination ip address
    delay(100);
    SpiSerial.print("set ip remote 5005\r\n"); // udp destination ip address
    delay(100);
    SpiSerial.print("save\r\n"); // save to rn-131c nv memory
    delay(100);
    SpiSerial.print("reboot\r\n"); //  reboot rn-131c
    delay(100);
    SpiSerial.print("exit\r\n"); //  exit "command" mode enter "transparent" mode 
    delay(100);
}


void loop() {
    while(SpiSerial.available() > 0) {
        Serial.print((char)SpiSerial.read());
    }

    if(Serial.available()) { // Outgoing data
       char c=(char)Serial.read();
       Serial.print(c);
       SpiSerial.print(c);
    }
    SpiSerial.print("Woof Woof\r\n"); // I expect this to be seen by a udp listener on the local network
    Serial.print("Woof Woof\r\n"); 
    delay(1000);
}

