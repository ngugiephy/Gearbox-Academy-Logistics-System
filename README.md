# GearBox Academy Logistics System
## _Automated Cabinet System_

[![GearBoxKe](https://gearbox.ke/academy/)](https://gearbox.ke/products/solid)



An automated cabinet system where users can access cabinet from their phones.


## Features
- search items in the cabinet
- view graphs of items taken
- selection of either one or more items
- the number of times/days and the number of items picked

## Languages used
- backend - Python Flask,
          - Database MySql
- Front-End - JavaScript, Html, CSS, Bootstrap


## Hardware : - esp 32 and C Language

And of course GearBox Logistic System itself is a source with a [public repository][https://github.com/ngugiephy/Gearbox-Academy-Logistics-System]
 on GitHub.

## Installation

GearBox Logistics requires [python](https://python.org/) v3.8 to run.

Install the dependencies and devDependencies and start the server.
## Setup steps
Download MySQL `sudo apt-get install mysql-server`
Install Python requirements 
Change to websites working directory `cd /home/pi/Gearbox-Academy-Logistics-System/`
Install the requirements `pip install -r requirements.txt`
Launch the website `python3 main.py`

## Setting Up MQTT
Publish  and subscribe MQTT server.
Set up steps
1. Terminal instructions.
	a. installed mosquitto broker
		`sudo apt install mosquitto`
	b. installed mosquitto clients
		`sudo apt install mosquitto-clients`
c. Created a config file in /etc/mosquitto/conf.d/ and named it default.conf, with      contents
		1.Allow anonymous true
 		2.listener 1883
	d. Start mosquitto broker
		`mosquitto -v`
2. Arduino IDE
-  installed pubsubclient libraries and ESP8266 board packages
-  Codebase in github repo

## Plugins

GearBox Logistics System is currently extended with the following plugins.
Instructions on how to use them in your own application are linked below.

| Plugin | README |
| ------ | ------ |
| GitHub | [https://github.com/ngugiephy/Gearbox-Academy-Logistics-System#readme |]
| Google Drive | [https://docs.google.com/document/d/1huxFB03lt4uXrBaYsIJic_tahVgxV3P_V_l8NZOQ9Ek/edit#] |
|GearBox Academy |[https://gearbox.ke/academy/]
|Facebook | [https://m.facebook.com/GearboxKE/]
|Youtube  | [https://www.youtube.com/channel/UCb6LwNO2Lk4iEFTy--biWdQ]
|Twitter  | [https://mobile.twitter.com/gearboxke]
|Images   | []





 





   

   
