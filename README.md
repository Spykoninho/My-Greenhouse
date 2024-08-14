# My-Greenhouse
Mobile application which displays all the information about your greenhouse (temperature, feeled temperature, air humidity and soil humidity), and which sends you all other important information (weather, etc.).

## Summary
- [How To Install the Project](#how-to-install-the-project)
- [Languages and Technologies](#languages-and-technologies)
   - [Web application](#Web-application)
   - [Mobile application](#Mobile-application)
   - [Database](#database)
   - [Docker](#docker)
- [Run](#run)
- [License](#license)
- [Authors](#authors)

## Products
Here is the hardware i'm using for the project with the link where i'm buying it :
- [Mini breadboard](https://fr.aliexpress.com/item/32614008350.html?spm=a2g0o.productlist.0.0.5dd7wwSAwwSAc0&mp=1&gatewayAdapt=glo2fra#nav-specification)
- [Kit Pi Zero W](https://www.kubii.com/fr/kits-nano-ordinateurs/2077-kit-pi-zero-w-kubii-3272496009509.html)
- [Arduino Nano Every with headers](https://store.arduino.cc/en-fr/products/arduino-nano-every-with-headers)
- [DHT 22 sensor](https://fr.aliexpress.com/item/1005005545184001.html?spm=a2g0o.productlist.main.9.7d1dszNGszNGfj&algo_pvid=09bab774-abe0-45ee-97b6-eded12b93e16&utparam-url=scene%3Asearch%7Cquery_from%3A)
- [Soil humidity](https://fr.aliexpress.com/item/1005004634714711.html?spm=a2g0o.productlist.main.11.78ff7dc2bByJCn&algo_pvid=4061f8f3-bbaf-43a1-b214-98e3392f1209&utparam-url=scene%3Asearch%7Cquery_from%3A)
- [Usb Conn Cable Type a-Micro B](https://www.amazon.fr/gp/product/B0093LID6K/ref=ewc_pr_img_1?smid=A1X6FK5RDHNB96&psc=1)

Total price : ~ 63.5€ 

## How To Install the Project
Here is all the steps to follow which will make your My Greenhouse's box working well !

### 1. Hardware Installation
First, power on your Raspberry with the SD card inside, connect it in HDMI and in USB with a keyboard, configure it, connect it on the wifi and install the updates.

You can put a static ip to connect easily on SSH.
#### Raspberry Pi Config
1. go to your Desktop folder : cd Desktop/
2. clone the github repo : git clone https://github.com/Spykoninho/My-Greenhouse.git
3. put the env variables : follow the env-example file
   1. sudo nano /etc/environment
   2. source /etc/environment
4. exec the file configUsr.sh : 
   1. chmod +x ~/Desktop/My-Greenhouse/configUsr.sh
   2. sudo ./configUsr.sh (it's possible that it's not recognize the env variable API_IP_HOST at the beginning)
   3. Follow the instructions

#### Arduino config
1. Install the arduino IDE on your computer
2. Link your arduino on your computer
3. On your IDE, select 'Arduino Nano Every'
4. Click YES on the popup.
5. Accept the download request
6. Go on the library manager and download the 'DHT sensor library' by Adafruit
7. Paste the code in [scriptDHT](/scriptDHT.ino)
8. Verify and upload the code.

#### Connect the Raspberry and the Arduino
1. Go on your Raspberry, install python3 : 
   1. sudo apt-get install python3
   2. sudo apt-get install python3-pip
   3. pip install virtualenv
2. Create a virtual env
   1. Go on Desktop/ folder : cd ~/Desktop
   2. virtualenv virtualenv_name or /home/USER/.local/bin/virtualenv
   3. source venvPython/bin/activate
3. Install dependancies :
   1. python3 -m pip install requests
   2. pip install pyserial
4. Connect the sensor (see picture below)

5. Go on ~/Desktop/My-Greenhouse
6. exec the python file [raspArduino.py](./raspArduino.py)

## Languages and Technologies

### Web application
#### - Front-End
![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)

#### - Back-End
![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white)
![Express.js](https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB)

### Mobile application
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

### Database 
![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)

### Containerization
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

## Run
### Required 
- Docker installation with docker compose
### Commands for developping
** Run for the first time ** ```docker compose up```

## License

<img src="https://img.shields.io/github/license/Ileriayo/markdown-badges?style=for-the-badge">

This project is under MIT License with an additional clause to prevent commercial use.

See [the license](./.github/LICENSE)

## Authors

- <a href="https://github.com/Spykoninho">@SpyKo</a>

## For contributors
See [the contributors guide](./.github/CONTRIBUTING.md)

## Changelog
See [the changelog](./.github/CHANGELOG.md)
