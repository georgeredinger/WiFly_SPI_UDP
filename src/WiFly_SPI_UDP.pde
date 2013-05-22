#include "WiFly.h"
#include "Credentials.h"
extern void reset_now();

void echo() {
    delay(100);
    while(SpiSerial.available() > 0) {
        Serial.print((char)SpiSerial.read());
    }
}


void setup() {

    Serial.begin(9600);
    Serial.println("\n\r\n\rWiFly Shield UDP blaster ");

    reset_now(); // allways start with factory defaults to insure  repeatable setup

    WiFly.begin();

    if (!WiFly.join(ssid, passphrase)) {
        Serial.println("Association failed.");
        while (1) {
            // Hang on failure.
        }
    }
    Serial.println("Associated!");
    SpiSerial.print("get ip\r\n");                    echo();// show ip address etc
    SpiSerial.print("set ip proto 1\r\n");            echo();// enter UDP mode 
    SpiSerial.print("set ip host 10.10.50.255\r\n");  echo();// udp destination ip address
    SpiSerial.print("set ip remote 5005\r\n");        echo();// udp destination ip address
    SpiSerial.print("save\r\n");                      echo();// save to rn-131c nv memory
    SpiSerial.print("reboot\r\n");                    echo();//  reboot rn-131c
    SpiSerial.print("exit\r\n");                             //  exit "command" mode enter "transparent" mode 
    Serial.print("ready to send via UDP");
}


void loop() {
    while(SpiSerial.available() > 0) {
        Serial.print((char)SpiSerial.read());
    }

    if(Serial.available()) { // Outgoing data
       char c=(char)Serial.read();
//       Serial.print(c);
       SpiSerial.print(c);
    }
//    SpiSerial.print("Woof Woof\r\n"); // I expect this to be seen by a udp listener on the local network
//    Serial.print("Woof Woof\r\n"); 
 //   delay(1000);
}

