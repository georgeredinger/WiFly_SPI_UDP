#include "WiFly.h"
#include "Credentials.h"
extern void reset_now();
int woof_count=0;
char udp_message[64];
char count[16]="bogus";


void echo() {
    delay(500);
    while(SpiSerial.available() > 0) {
        Serial.print((char)SpiSerial.read());
    }
}


void setup() {
  char ssid_cmd[64] = "set wlan ssid "; 
  char phrase_cmd[64] = "set wlan phrase " ;
  char join_cmd[64] =  "join ";

  strcat(ssid_cmd,ssid);
  strcat(phrase_cmd,passphrase);
  strcat(join_cmd,ssid);
  Serial.begin(9600);
  Serial.println("\n\r\n\rWiFly Shield UDP blaster ");

  reset_now(); // allways start with factory defaults to insure  repeatable setup

  WiFly.begin();

  SpiSerial.print("set wlan auth 4\r");echo();
  SpiSerial.print(ssid_cmd);SpiSerial.print("\r");echo();
  SpiSerial.print(phrase_cmd);SpiSerial.print("\r");echo();
  SpiSerial.print(join_cmd);SpiSerial.print("\r");echo();
  SpiSerial.print("set ip proto 1\r");echo();
  SpiSerial.print("set ip host 255.255.255.255\r");echo();
  SpiSerial.print("set ip remote 55555\r");echo();
  SpiSerial.print("save\r");echo();
  SpiSerial.print("reboot\r");echo();
  delay(2000);
  SpiSerial.print("$$$");echo();
  SpiSerial.print(join_cmd);SpiSerial.print("\r");echo();
  SpiSerial.print("exit\r");echo();
}


void loop() {
   sprintf(count,"%d",woof_count++);
   strcpy(udp_message,"Woof Woof ");
   strcat(udp_message,count);
   strcat(udp_message,"\r");

   SpiSerial.print(udp_message); // I expect this to be seen by a udp listener on the local network

   delay(1000);
}

