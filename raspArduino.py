import serial,time, os
import requests

env = os.environ
jwt = env.get("JWT")
greenhouse_id = env.get("GREENHOUSE_ID")
api_host = env.get("API_IP_HOST")

if __name__ == '__main__':
    with serial.Serial("/dev/ttyACM0", 9600, timeout=1) as arduino:
        if arduino.isOpen():
            try:
                while True:
                    while arduino.inWaiting()==0: pass
                    if  arduino.inWaiting()>0: 
                        answer=arduino.readline().decode('utf-8').rstrip()
                        sensor_result = answer.split(' ')
                        if (len(sensor_result) == 4):
                            humidity=sensor_result[0]
                            temperature=sensor_result[1]
                            feel_temperature=sensor_result[2]
                            soil_humidity=sensor_result[3]
                            saveGreenhouseData = api_host+"/api/saveGreenhouseData"
                            r = requests.post(url=saveGreenhouseData, data = {'idGreenhouse': greenhouse_id, 'humidity': humidity, 'soil_humidity': soil_humidity, 'temperature': temperature, 'feel_temperature': feel_temperature}, headers = {"Authorization": jwt})
            except KeyboardInterrupt:
                print("KeyboardInterrupt has been caught.")

