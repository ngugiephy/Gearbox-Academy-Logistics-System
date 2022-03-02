//WiFi manager library can be installed from --https://github.com/tzapu/WiFiManager
//ESP_DoubleResetDetector library can be installed from --https://github.com/khoih-prog/ESP_DoubleResetDetector
//ArduinoJson library can be installed from --https://github.com/bblanchon/ArduinoJson  
//PubSubClient library from library manager

#define DEBUG 1        //set 1 for serial read statements

#define ESP_DRD_USE_SPIFFS true

#include <Arduino.h>
#include <WiFi.h>
#include <FS.h>
#include <SPIFFS.h>
#include <PubSubClient.h>
#include <WiFiManager.h>
#include <ESP_DoubleResetDetector.h>
#include <ArduinoJson.h>

#include "soc/soc.h"
#include "soc/rtc_cntl_reg.h"

#define JSON_CONFIG_FILE "/sample_config.json"
#define DRD_TIMEOUT 10
#define DRD_ADDRESS 0


#if DEBUG == 1
#define debug(x) Serial.print(x)
#define debugln(x) Serial.println(x)
#else
#define debug(x) 
#define debugln(x)
#endif


//output pins
#define Buzzer          14  //connected to buzzer
#define LED_PIN         02  //LED PIN INTERNAL
#define TRIGGER_PIN      0  //Force reset

void (* resetFunc)(void) = 0;         // creating pointer at memory address 0

WiFiClient espClient;
PubSubClient client(espClient);
unsigned long lastMsg = 0;
#define MSG_BUFFER_SIZE  (50)
char msg[MSG_BUFFER_SIZE];
int value = 0;

int doors[8]   = {32,  4,  5, 12, 13, 18, 19, 22};  // to locks
int doors_b[8] = {15, 21, 23, 25, 26, 27, 33, 35};  // to limit switch
          //index  0   1   2   3   4   5   6   7 
          //door   1   2   3   4   5   6   7   8
//An external pull up resistor is added to pim 35
 
int prev_State[8];
int curr_State[8];

DoubleResetDetector *drd;
bool shouldSaveConfig = false;

char MQTTIP[50] = "pi.local";
int MQTT_PORT = 1883;
bool EnableBuzzer = true;

WiFiManager wm;

void saveConfigFile()
{
  debugln(F("Saving config"));
  StaticJsonDocument<512> json;
  json["MQTTIP"] = MQTTIP;
  json["MQTT_PORT"] = MQTT_PORT;
  json["EnableBuzzer"] = EnableBuzzer;

  File configFile = SPIFFS.open(JSON_CONFIG_FILE, "w");
  if (!configFile)
  {
    debugln("failed to open config file for writing");
  }

  serializeJsonPretty(json, Serial);
  if (serializeJson(json, configFile) == 0)
  {
    debugln(F("Failed to write to file"));
  }
  configFile.close();
}

bool loadConfigFile()
{
  //clean FS, for testing
  // SPIFFS.format();

  //read configuration from FS json
  debugln("mounting FS...");

  if (SPIFFS.begin(false) || SPIFFS.begin(true))
  {
    debugln("mounted file system");
    if (SPIFFS.exists(JSON_CONFIG_FILE))
    {
      //file exists, reading and loading
      debugln("reading config file");
      File configFile = SPIFFS.open(JSON_CONFIG_FILE, "r");
      if (configFile)
      {
        debugln("opened config file");
        StaticJsonDocument<512> json;
        DeserializationError error = deserializeJson(json, configFile);
        serializeJsonPretty(json, Serial);
        if (!error)
        {
          debugln("\nparsed json");

          strcpy(MQTTIP, json["MQTTIP"]);
          MQTT_PORT = json["MQTT_PORT"].as<int>();
          EnableBuzzer = json["EnableBuzzer"].as<bool>();

          return true;
        }
        else
        {
          debugln("failed to load json config");
        }
      }
    }
  }
  else
  {
    debugln("failed to mount FS");
  }
  //end read
  return false;
}
//callback notifying us of the need to save config
void saveConfigCallback()
{
  debugln("Should save config");
  shouldSaveConfig = true;
}

void configModeCallback(WiFiManager *myWiFiManager)
{
  debugln("Entered Conf Mode");

  debug("Config SSID: ");
  debugln(myWiFiManager->getConfigPortalSSID());

  debug("Config IP Address: ");
  debugln(WiFi.softAPIP());
}

void LED(bool state)
{
  digitalWrite(LED_PIN, state);
}

bool force_state = false;
void blink_para(int timeout_){
  
  unsigned int previous_time = millis();
  unsigned int current_time = millis();

  bool Lstate = true;

  while((current_time - previous_time) < timeout_){
      
    volatile unsigned int previous_t;
    unsigned int current_t = millis();
    int t = 200;
    
    if((current_t - previous_t) > t){
      LED(Lstate);
      Lstate = !Lstate;  
      previous_t = current_t; 
    }
    
    if(digitalRead(TRIGGER_PIN) == LOW) {
     force_state = true;
     
     debugln("button  pressed");
     LED(true);
     break;
    }    
    current_time = millis();
  }
  LED(true);
}

void WifiManagersetup(){


  bool forceConfig = false;

  drd = new DoubleResetDetector(DRD_TIMEOUT, DRD_ADDRESS);
  if (drd->detectDoubleReset())
  {
    debugln(F("Forcing config mode as there was a Double reset detected -- currently disabled"));
   // forceConfig = true;  // uncomment to enablr double reset funct 
  }
  
  debugln("start b check");
  blink_para(5000);
  force_state == 1 ? forceConfig = true : forceConfig = false;
  debugln("end of b check");

  bool spiffsSetup = loadConfigFile();
  if (!spiffsSetup)
  {
    debugln(F("Forcing config mode as there is no saved config"));
    forceConfig = true;
  }

  //WiFi.disconnect();
  WiFi.mode(WIFI_STA); // explicitly set mode, esp defaults to STA+AP
  delay(10);

  // wm.resetSettings(); // wipe settings

  //WiFiManager wm;

  //wm.resetSettings(); // wipe settings
  //set config save notify callback
  wm.setSaveConfigCallback(saveConfigCallback);
  //set callback that gets called when connecting to previous WiFi fails, and enters Access Point mode
  wm.setAPCallback(configModeCallback);

  //--- additional Configs params ---

  // Text box for IP adress
  WiFiManagerParameter custom_text_box("key_text", "Enter your MQTT server IP Address", MQTTIP, 50); // 50 == max length

  // Text box for port
  char convertedValue[6];
  sprintf(convertedValue, "%d", MQTT_PORT); // Need to convert to string to display a default value.

  WiFiManagerParameter custom_text_box_num("key_num", "Enter your server port", convertedValue, 7); // 7 == max length

  //Check Box
  char *customHtml;
  if (EnableBuzzer)
  {
    customHtml = "type=\"checkbox\" checked";
  }
  else
  {
    customHtml = "type=\"checkbox\"";
  }
  WiFiManagerParameter custom_checkbox("key_bool", "Enable Buzzer", "T", 2, customHtml); 

  wm.addParameter(&custom_text_box);
  wm.addParameter(&custom_text_box_num);
  wm.addParameter(&custom_checkbox);

  debugln("hello");

  if (forceConfig)
  {
    if (!wm.startConfigPortal("GA_Logistics", "clock420"))
    {
      debugln("failed to connect and hit timeout");
      delay(3000);
      //reset and try again, or maybe put it to deep sleep
      ESP.restart();
      delay(5000);
    }
  }
  else
  {
    if (!wm.autoConnect("GA_Logistics", "clock420"))
    {
      debugln("failed to connect and hit timeout");
      delay(3000);
      // if we still have not connected restart and try all over again
      ESP.restart();
      delay(5000);
    }
  }

  // If we get here, we are connected to the WiFi
  
  debugln("");
  debugln("WiFi connected");
  debugln("IP address: ");
  debugln(WiFi.localIP());

  // dealing with the user config values

  // Copy the IP value
  strncpy(MQTTIP, custom_text_box.getValue(), sizeof(MQTTIP));
  Serial.print("MQTTIP: ");
  debugln(MQTTIP);

  //Convert the PORT value
  MQTT_PORT = atoi(custom_text_box_num.getValue());
  Serial.print("MQTT_PORT: ");
  debugln(MQTT_PORT);

  //Handle the bool value
  EnableBuzzer = (strncmp(custom_checkbox.getValue(), "T", 1) == 0);
  Serial.print("EnableBuzzer: ");
  if (EnableBuzzer)
  {
    debugln("Buzzer true");
  }
  else
  {
    debugln("Buzzer false");
  }

  //save the custom parameters to FS
  if (shouldSaveConfig)
  {
    saveConfigFile();
  }


}

void Buzz(bool state)
{

    if (EnableBuzzer)
  {
    digitalWrite(Buzzer, state);
  }
  else
  {
    digitalWrite(Buzzer, LOW);
  }

}

bool get_ddata(int door_)
{
int doorState = digitalRead(doors_b[door_]);
bool r;
doorState == 1 ? r = false: r = true;
//          when open - false
return(r);
}


void callback(char* topic, byte* payload, unsigned int length) {
  debug("Message arrived [");
  debug(topic);
  debug("] ");
  for (int i = 0; i < length; i++) {
    debug((char)payload[i]);
  }
  debugln();
  //e.g Message arrived [inTopic] 1

  // Open door one if 1 was received as first character
  if ((char)payload[0] == '1') {

    if(get_ddata(0)) {
      //debugln("Opening door");
      Buzz(true);
      digitalWrite(doors[0], HIGH);
      delay(200);
      digitalWrite(doors[0], LOW);
      Buzz(false);
    } 
    else  {
      //debugln("Door already open");  
      Buzz(true);
      delay(200);
      Buzz(false);
     }  
   
  }
  else if ((char)payload[0] == '2'){

    if(get_ddata(1)) {
      Buzz(true);
      digitalWrite(doors[1], HIGH);
      delay(200);
      digitalWrite(doors[1], LOW);
      Buzz(false);
    }
    else  {
      Buzz(true);
      delay(200);
      Buzz(false);
     }  
  }
  else if ((char)payload[0] == '3'){

    if(get_ddata(2)) {
      Buzz(true);
      digitalWrite(doors[2], HIGH);
      delay(200);
      digitalWrite(doors[2], LOW);
      Buzz(false);
    }
    else  {
      Buzz(true);
      delay(200);
      Buzz(false);
     }  

  }

  else if ((char)payload[0] == '4'){

    if(get_ddata(3)) {
      Buzz(true);
      digitalWrite(doors[3], HIGH);
      delay(200);
      digitalWrite(doors[3], LOW);
      Buzz(false);
    }
    else  {
      Buzz(true);
      delay(200);
      Buzz(false);
     }        
  }
  else if ((char)payload[0] == '5'){
    
    if(get_ddata(4)) {
      Buzz(true);
      digitalWrite(doors[4], HIGH);
      delay(200);
      digitalWrite(doors[4], LOW);
      Buzz(false);
    }
    else  {
      Buzz(true);
      delay(200);
      Buzz(false);
     }     

  }
  else if ((char)payload[0] == '6'){

    if(get_ddata(5)) {
    Buzz(true);
    digitalWrite(doors[5], HIGH);
    delay(200);
    digitalWrite(doors[5], LOW);
    Buzz(false);
    }
    else  {
      Buzz(true);
      delay(200);
      Buzz(false);
     }       
  }
  else if ((char)payload[0] == '7'){

    if(get_ddata(6)) {
    Buzz(true);
    digitalWrite(doors[6], HIGH);
    delay(200);
    digitalWrite(doors[6], LOW);
    Buzz(false);
    }
    else  {
      Buzz(true);
      delay(200);
      Buzz(false);
     }       
  }
  else if ((char)payload[0] == '8'){

    if(get_ddata(7)) {
    Buzz(true);
    digitalWrite(doors[7], HIGH);
    delay(200);
    digitalWrite(doors[7], LOW);
    Buzz(false);
    }
    else  {
      Buzz(true);
      delay(200);
      Buzz(false);
     }        
  }
  else {
    LED(true); delay(100);LED(false);delay(100);LED(true);delay(100);LED(false);
    delay(100);LED(true);delay(100);LED(false);
    //blink LED 3 times for wrong command 
    }
    

}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    debug("Attempting MQTT connection...");
    // Create a random client ID
    String clientId = "ESP8266Client-";
    clientId += String(random(0xffff), HEX);
    // Attempt to connect
    if (client.connect(clientId.c_str())) {
      debugln("connected");
      // Once connected, publish an announcement...
      client.publish("outTopic", "Program Started ..");
      // ... and resubscribe
      client.subscribe("inTopic");
    } else {
      debug("failed, rc=");
      debug(client.state());
      debugln(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void upload(int doorno, String doorstatus)
{  
  //prints data to be sent
  //upload code
  debugln("\nData ____ \n");
  String senddata = "Door " +(String)doorno + " " + (String)doorstatus;
  debugln("\n"+senddata + "_______");

   if (!client.connected()) {
    reconnect();
  }
      debug("\t\tAttempting MQTT connection...");
    // Create a random client ID
    String clientId = "ESP8266Client-";
    clientId += String(random(0xffff), HEX);
    // Attempt to connect
    if (client.connect(clientId.c_str())) {
      debugln("connected");

    debug("\n\nSending:\n  outTopic: ");
    debugln(senddata);
    
     char mqttdata[15];
     senddata.toCharArray(mqttdata, 15);

    client.publish("outTopic", mqttdata);
    delay(150);
    }
 
}

void check_state(){
   
  for(int i = 0; i < 8; i++){
       curr_State[i] = digitalRead(doors_b[i]);
       bool statechange;  
       String Cstate;
       //      if                         else 
       curr_State[i] == 1 ? Cstate = " Open":Cstate = " Closed";
       //      if                                          else
       (curr_State[i] == prev_State[i]) ? statechange = false:statechange = true;  
       int d = i+1;
       if(statechange == true){
         debug("Door state changed on door " + (String)d + " - Door now" + (String)Cstate + "\n" );    
          upload(d,Cstate);
       }       
       //debug("Door " + (String)d + " - " + state + "\n" );//GM     
       prev_State[i] = curr_State[i];
  }

}

void checkButton(){
  // check for button press
  if ( digitalRead(TRIGGER_PIN) == LOW ) {
    // poor mans debounce/press-hold
    delay(50);
    if( digitalRead(TRIGGER_PIN) == LOW ){
      debugln("Button Pressed");
      
      LED(true);
                  
      // start portal w delay
      debugln("Starting config portal");
      wm.setConfigPortalTimeout(60);
      
      if (!wm.startConfigPortal("GA_Logistics", "clock420")) {
        debugln("failed to connect or hit timeout");
        delay(3000);
        //ESP.restart();
      } else {
        //if you get here you have connected to the WiFi
        debugln("connected...yeey :)");
        LED(false);
      }
    }
  }
}

void setup() {
 
 
  WRITE_PERI_REG(RTC_CNTL_BROWN_OUT_REG, 0);
  Serial.begin(115200);

  delay(1000);

  debugln("\n\nStarting program");
  
  
  pinMode(LED_PIN, OUTPUT);
  pinMode(Buzzer, OUTPUT);

  LED(true);
  WifiManagersetup();
  
  //setup_wifi();
  randomSeed(micros());  


  client.setServer(MQTTIP, MQTT_PORT);   
  client.setCallback(callback);
  

    for(int i = 0; i<8; i++){
       pinMode(doors[i], OUTPUT);
     }
    for(int i = 0; i<8; i++){
       pinMode(doors_b[i], INPUT_PULLUP);
     }
 

/*   //Test door function 
   while(1){
      for (int i = 0; i<8; i++){
        
        String state;
        digitalRead(doors_b[i]) == 1 ? state = "Open":state = " Closed";
        int d = i+1;
        debug("Door " + (String)d + " - " + state + "\n" );  
      }
      delay(600);
   }
*/

  debugln("\nInitial Door status...\n");
  
      for(int i = 0; i < 8; i++){
        prev_State[i] = digitalRead(doors_b[i]);
        String state;
        digitalRead(doors_b[i]) == 1 ? state = "Open":state = " Closed";
        
          int d = i+1;
          debug("Door " + (String)d + " - " + state + "\n" );     
        
      }
      
  debugln("\n---------------------------------------------\n");
  delay(500);
  
  
  digitalWrite(LED_PIN, LOW);
  pinMode(TRIGGER_PIN, INPUT);
  debugln("\n\t\tInit...\n");
  
}

void loop() {

  check_state();
  
  if (!client.connected()) {

      if ((WiFi.status() != WL_CONNECTED)){
       //resetFunc();
       ESP.restart();
      }

    reconnect();
  }

  client.loop();
  //drd->loop();   //uncomment for doublereset for config page functionality
  checkButton();   //boot pin to force config page

}
