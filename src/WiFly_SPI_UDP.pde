#include "WiFly.h"
#include "Credentials.h"
#define MY_NTP_SERVER "64.90.182.55"
const char s_WT_SETUP_00[] PROGMEM = MY_NTP_SERVER;
const char s_WT_SETUP_01[] PROGMEM = "set u m 0x1";
const char s_WT_SETUP_02[] PROGMEM = "set comm remote 0";
const char s_WT_SETUP_03[] PROGMEM = "set comm idle 30";
const char s_WT_SETUP_04[] PROGMEM = "set comm time 2000";
const char s_WT_SETUP_05[] PROGMEM = "set comm size 64";
const char s_WT_SETUP_06[] PROGMEM = "set comm match 0x0d";
const char s_WT_SETUP_07[] PROGMEM = "time";
const char s_WT_TO_UDP_01[] PROGMEM = "set ip proto 1 ";
const char s_WT_TO_UDP_02[] PROGMEM = "set ip host ";
const char s_WT_TO_UDP_03[] PROGMEM = "set ip remote ";
const char s_WT_TO_UDP_04[] PROGMEM = "set ip local ";
const char s_WT_FROM_UDP_01[] PROGMEM = "set ip proto 2 ";
const char s_WT_FROM_UDP_02[] PROGMEM = "set ip host localhost";
const char s_WT_FROM_UDP_03[] PROGMEM = "set ip remote 80";
const char s_WT_FROM_UDP_04[] PROGMEM = "set ip local 2000";
const char s_WT_WIFLY_SAVE[] PROGMEM = "save ";
const char s_WT_WIFLY_REBOOT[] PROGMEM = "reboot ";
const char s_WT_STATUS_SENSORS[] PROGMEM = "show q 0x177 ";
const char s_WT_STATUS_TEMP[] PROGMEM = "show q t ";
const char s_WT_STATUS_RSSI[] PROGMEM = "show rssi ";
const char s_WT_STATUS_BATT[] PROGMEM = "show battery ";
const char s_WT_MSG_JOIN[] PROGMEM = "Credentials Set, Joining ";
const char s_WT_MSG_START_WEBTIME[] PROGMEM = "Starting UDPSample - Please wait. ";
const char s_WT_MSG_RAM[] PROGMEM = "RAM :";
const char s_WT_MSG_START_WIFLY[] PROGMEM = "Started WiFly, RAM :";
const char s_WT_MSG_WIFI[] PROGMEM = "Initial WiFi Settings :";
const char s_WT_MSG_APP_SETTINGS[] PROGMEM = "Configure UDPSample Settings...";
const char s_WT_MSG_TO_UDP[] PROGMEM = "Switching to UDP mode...";
const char s_WT_MSG_FROM_UDP[] PROGMEM = "Switching from UDP mode to TCP...";
const char s_WT_HTML_HEAD_01[] PROGMEM = "HTTP/1.1 200 OK \r ";
const char s_WT_HTML_HEAD_02[] PROGMEM = "Content-Type: text/html;charset=UTF-8\r ";
const char s_WT_HTML_HEAD_03[] PROGMEM = " Content-Length: ";
const char s_WT_HTML_HEAD_04[] PROGMEM = "Connection: close \r\n\r\n ";

#define IDX_WT_SETUP_00 0
#define IDX_WT_SETUP_01 IDX_WT_SETUP_00 +1
#define IDX_WT_SETUP_02 IDX_WT_SETUP_01 +1
#define IDX_WT_SETUP_03 IDX_WT_SETUP_02 +1
#define IDX_WT_SETUP_04 IDX_WT_SETUP_03 +1
#define IDX_WT_SETUP_05 IDX_WT_SETUP_04 +1
#define IDX_WT_SETUP_06 IDX_WT_SETUP_05 +1
#define IDX_WT_SETUP_07 IDX_WT_SETUP_06 +1

#define IDX_WT_TO_UDP_01 IDX_WT_SETUP_07 + 1
#define IDX_WT_TO_UDP_02 IDX_WT_TO_UDP_01 + 1
#define IDX_WT_TO_UDP_03 IDX_WT_TO_UDP_02 + 1
#define IDX_WT_TO_UDP_04 IDX_WT_TO_UDP_03 + 1

#define IDX_WT_FROM_UDP_01 IDX_WT_TO_UDP_04 + 1
#define IDX_WT_FROM_UDP_02 IDX_WT_FROM_UDP_01 + 1
#define IDX_WT_FROM_UDP_03 IDX_WT_FROM_UDP_02 + 1
#define IDX_WT_FROM_UDP_04 IDX_WT_FROM_UDP_03 + 1

#define IDX_WT_WIFLY_SAVE IDX_WT_FROM_UDP_04 + 1
#define IDX_WT_WIFLY_REBOOT IDX_WT_WIFLY_SAVE + 1

#define IDX_WT_STATUS_SENSORS    IDX_WT_WIFLY_REBOOT + 1 
#define IDX_WT_STATUS_TEMP       IDX_WT_STATUS_SENSORS +1
#define IDX_WT_STATUS_RSSI       IDX_WT_STATUS_TEMP +1
#define IDX_WT_STATUS_BATT       IDX_WT_STATUS_RSSI +1

#define IDX_WT_MSG_JOIN          IDX_WT_STATUS_BATT +1
#define IDX_WT_MSG_START_WEBTIME IDX_WT_MSG_JOIN +1
#define IDX_WT_MSG_RAM           IDX_WT_MSG_START_WEBTIME +1
#define IDX_WT_MSG_START_WIFLY   IDX_WT_MSG_RAM +1
#define IDX_WT_MSG_WIFI          IDX_WT_MSG_START_WIFLY +1
#define IDX_WT_MSG_APP_SETTINGS  IDX_WT_MSG_WIFI +1
#define IDX_WT_MSG_TO_UDP        IDX_WT_MSG_APP_SETTINGS +1
#define IDX_WT_MSG_FROM_UDP      IDX_WT_MSG_TO_UDP +1

#define IDX_WT_HTML_HEAD_01      IDX_WT_MSG_FROM_UDP + 1
#define IDX_WT_HTML_HEAD_02      IDX_WT_HTML_HEAD_01 + 1
#define IDX_WT_HTML_HEAD_03      IDX_WT_HTML_HEAD_02 + 1
#define IDX_WT_HTML_HEAD_04      IDX_WT_HTML_HEAD_03 + 1



const char *WT_string_table[] =
{
    s_WT_SETUP_00,
    s_WT_SETUP_01,
    s_WT_SETUP_02,
    s_WT_SETUP_03,
    s_WT_SETUP_04,
    s_WT_SETUP_05,
    s_WT_SETUP_06,
    s_WT_SETUP_07,
    s_WT_TO_UDP_01,
    s_WT_TO_UDP_02,
    s_WT_TO_UDP_03,
    s_WT_TO_UDP_04,
    s_WT_FROM_UDP_01,
    s_WT_FROM_UDP_02,
    s_WT_FROM_UDP_03,
    s_WT_FROM_UDP_04,
    s_WT_WIFLY_SAVE,
    s_WT_WIFLY_REBOOT,
    s_WT_STATUS_SENSORS,
    s_WT_STATUS_TEMP,
    s_WT_STATUS_RSSI,
    s_WT_STATUS_BATT,
    s_WT_MSG_JOIN,
    s_WT_MSG_START_WEBTIME,
    s_WT_MSG_RAM,
    s_WT_MSG_START_WIFLY,
    s_WT_MSG_WIFI,
    s_WT_MSG_APP_SETTINGS,
    s_WT_MSG_TO_UDP,
    s_WT_MSG_FROM_UDP,
    s_WT_HTML_HEAD_01,
    s_WT_HTML_HEAD_02,
    s_WT_HTML_HEAD_03,
    s_WT_HTML_HEAD_04
};


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

