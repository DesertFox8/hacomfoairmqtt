# Home Assistant Add-on: hacomfoairmqtt

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg

Home Assistant Add-On for Zehnder ComfoAir serial controlled ventilation systems via RS232 serial connection and MQTT.
While the scripts has been developed using the protocol description for Zehnder ComfoAir devices, it should also be compatible with largely similar systems from other manufacturers, such as StorkAir WHR930, Wernig G90-380, and Paul Santos 370 DC. It has also undergone successful testing on a ComfoAir 350.

It is not compatible with the newer ComfoAir Q series or Aeris Next models as they use a different communication standard.

This work is based on scripts created for Domoticz integration <https://github.com/AlbertHakvoort/StorkAir-Zehnder-WHR-930-Domoticz-MQTT>

## Installation instructions



## Home Assistant Comfoair MQTT Configuration

Configuration Name | Description
------------ | -------------
SerialPort       | The Serialport to the Comfoair on the Host Linux Machine. Examples: /dev/ttyUSB0 or /dev/cuau3
MQTTServer       | IP Adress to your MQTT Server, may be different to the HA Server
MQTTPort         | Port of your MQTT Server. Default: 1883
MQTTKeepalive    | MQTT Keepalive Settings. Default: 45
MQTTUser         | MQTT User, if you enabled authorization on your MQTT Server. Default: False (no authentication)
MQTTPassword     | MQTT User Password, if you enabled authorization on your MQTT Server. Default: False (no authentication)
refresh_interval | Refresh Interval in Seconds. Default: 10
enablePcMode     | Automaticly enable PC Mode (disable comfosense). Default: False (disabled)
RS485_protocol   | Enable RS485 protocol, if false RSS232 is used Default: False (RS232)
debug            | Enable Debug Output. Default: False (disabled)

## MQTT Auto Discovery Configutation:

If you are using MQTT in Home Assistant, you will probably have the Auto Discovery enabled by default. The MQTT AD implementation is expected to run with the prefix "homeassistant/". 

### Configuration: HAEnableAutoDiscoverySensors = True

Configuration Name | Description
------------ | -------------
HAEnableAutoDiscoverySensors | Enable Home Assistant Auto Discovery
HAAutoDiscoveryDeviceId | Unique ID to use for Home Assistant Device Discovery
HAAutoDiscoveryDeviceName | Device name to show in the Home Assistant frontend
HAAutoDiscoveryDeviceManufacturer | Device manufacturer to show in the Home Assistant frontend
HAAutoDiscoveryDeviceModel | Device model to show in the Home Assistant frontend

If you enable Autodiscovery in this Service, you will get following entities:
The entity id consists of the `HAAutoDiscoveryDeviceName` and the Entity Name.

Entity Type | Entity Name | Unit | Description
------------| ----------- | ---- | -------------
sensor | Analog sensor 1 | % | Analog reading for accesories, eg: Comfosense CO2 sensor
sensor | Analog sensor 2 | % | Analog reading for accesories, eg: Comfosense CO2 sensor
sensor | Analog sensor 3 | % | Analog reading for accesories, eg: Comfosense CO2 sensor
sensor | Analog sensor 4 | % | Analog reading for accesories, eg: Comfosense CO2 sensor
sensor | Bypass valve    | % | Bypass valve value: 0 % = Closed, 100 % = Open
sensor | Return air level | % | Fan level for exhaust fan
sensor | Supply air level | % | Fan level for supply fan
sensor | Exhaust fan speed | rpm | Fan rotation speed for exhaust fan
sensor | Supply fan speed | rpm | Fan rotation speed for supply fan
sensor | Outside temperature | °C | Air temperature from outside
sensor | Supply temperature | °C | Air temperature supplied to the house
sensor | Return temperature | °C | Air temperature extracted from the house 
sensor | Exhaust temperature | °C | Air temperature going outside
sensor | Summer mode | | Current climate mode: `Summer` means cooling via bypass at nighttime, `Winter` means bypass always closed
sensor | Filter hours| h | Filter hours counter
number | Filter weeks | weeks | Configuration for filter weeks, possible values from 1 to 26, appears as "number" entity type in HA
button | Reset filter | | Button entity type to reset filter status
binary_sensor | Summer mode | | Current climate mode: `On` means cooling via bypass at nighttime, `Off` means bypass always closed
binary_sensor | Preheating status | | Whether the unit is preheating the air before it enters the heat exchanger.
binary_sensor | Bypass valve | | State of the bypass valve
binary_sensor | Filter status | | Whether or not the air filters need cleaning / replacing
sensor | EWT Temperature | °C | EWT Temperature (geothermal heat exchanger)
number | EWT Lower Set Temperature | °C | EWT Lower Set Temperature control
number | EWT Upper Set Temperature | °C | EWT Upper Set Temperature control
number | EWT speed up | % | EWT speed up control

### Configuration: HAEnableAutoDiscoveryClimate = False

Adding the Comfoair as an HAVC makes sense, since it has a temperature control and a fan.

Entity Name | Description
------------ | -------------
climate.ca350_climate | Expose Comfort Temperature Control & Fan Control

## HA Lovelace Widget

The following Lovelace widgets depend on the MQTT AD enities and can be used with this service:

* <https://github.com/TimWeyand/lovelace-comfoair>
* <https://github.com/mweimerskirch/lovelace-hacomfoairmqtt>
