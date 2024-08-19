#include <DHT.h>

#define DHTPin 6
#define DHTType 22
#define humiditySensorPin A0
#define sensorDryValue 570 // value for dry sensor
#define sensorWetValue 258 // value for wet sensor
int humiditySensorValue = 0;

DHT dht(DHTPin, DHTType);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  dht.begin();
}

void loop() {
  // put your main code here, to run repeatedly:
  int tauxHumidite = dht.readHumidity();
  int temperatureEnCelsius = dht.readTemperature();
  humiditySensorValue = analogRead(humiditySensorPin);
   
  if(isnan(tauxHumidite) || isnan(temperatureEnCelsius)){
    Serial.println("Aucune valeur retournée par le DHT22. Est-il bien branché ?");
    delay(5000);
    return;
  }

  int temperatureRessentieEnCelcius = dht.computeHeatIndex(temperatureEnCelsius, tauxHumidite, false);
  int percentageHumididy = map(humiditySensorValue, sensorWetValue, sensorDryValue, 100, 0);
  String result = String(tauxHumidite);
  result.concat(" ");
  result.concat(String(temperatureEnCelsius));
  result.concat(" ");  
  result.concat(String(temperatureRessentieEnCelcius));
  result.concat(" ");  
  result.concat(String(percentageHumididy));

  Serial.print(result);
  delay(5000);
}