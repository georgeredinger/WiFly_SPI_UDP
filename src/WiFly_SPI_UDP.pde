#include "WiFly.h"
#include "Credentials.h"

void setup() {

    Serial.begin(9600);
    Serial.println("\n\r\n\rWiFly Shield UDP blaster ");

    WiFly.begin();

    if (!WiFly.join(ssid, passphrase)) {
        Serial.println("Association failed.");
        while (1) {
            // Hang on failure.
        }
    }
    Serial.println("Associated!");

}


void loop() {
    while(SpiSerial.available() > 0) {
        Serial.print((char)SpiSerial.read());
    }

    if(Serial.available()) { // Outgoing data
        SpiSerial.print((char)Serial.read());
    }
}

