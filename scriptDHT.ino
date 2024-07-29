#include <DHT.h>

#define brocheBranchementDHT 6
#define typeDeDHT 22 

DHT dht(brocheBranchementDHT, typeDeDHT);

void setup() {
  Serial.begin(9600);

  dht.begin();
}

void loop() {
  int tauxHumidite = dht.readHumidity();
  int temperatureEnCelsius = dht.readTemperature();
  if(isnan(tauxHumidite) || isnan(temperatureEnCelsius)){
    Serial.println("Aucune valeur retournÃ©e par le DHT22. Est-il bien branchÃ© ?");
    delay(2000);
    return;
  }

  int temperatureRessentieEnCelcius = dht.computeHeatIndex(temperatureEnCelsius, tauxHumidite, false);
  String result = String(tauxHumidite);
  result.concat(" ");
  result.concat(String(temperatureEnCelsius));
  result.concat(" ");  
  result.concat(String(temperatureRessentieEnCelcius));

  Serial.print(result);
  
  delay(2000);
}