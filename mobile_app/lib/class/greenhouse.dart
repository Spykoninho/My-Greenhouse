class Greenhouse {
  var _greenhouse_name;
  var _humidity;
  var _soil_humidity;
  var _temperature;
  var _feel_temperature;
  var _last_update;
  var _id;
  Greenhouse(this._greenhouse_name, this._humidity, this._soil_humidity,
      this._temperature, this._feel_temperature, this._last_update, this._id);

  void setName(name) {
    name == null ? "NR" : name.toString();
    this._greenhouse_name = name;
  }

  void setHumidity(humidity) {
    humidity == null ? "NR" : humidity.toString();
    this._humidity = humidity;
  }

  void setSoilHumidity(soil_humidity) {
    soil_humidity == null ? "NR" : soil_humidity.toString();
    this._soil_humidity = soil_humidity;
  }

  void setTemperature(temperature) {
    temperature == null ? "NR" : temperature.toString();
    this._temperature = temperature;
  }

  void setFeelTemperature(feel_temperature) {
    feel_temperature == null ? "NR" : feel_temperature.toString();
    this._feel_temperature = feel_temperature;
  }

  void setLastUpdate(last_update) {
    last_update == null ? "NR" : last_update.toString();
    this._last_update = last_update;
  }

  void setId(id) {
    id == null ? "NR" : id.toString();
    this._id = id;
  }

  String getName() {
    var name = _greenhouse_name == null ? "NR" : _greenhouse_name;
    return name.toString();
  }

  String getHumidity() {
    var humidity = _humidity == null ? "NR" : _humidity;
    return humidity.toString();
  }

  String getSoilHumidity() {
    var soil_humidity = _soil_humidity == null ? "NR" : _soil_humidity;
    return soil_humidity.toString();
  }

  String getTemperature() {
    var temperature = _temperature == null ? "NR" : _temperature;
    return temperature.toString();
  }

  String getFeelTemperature() {
    var feel_temperature = _feel_temperature == null ? "NR" : _feel_temperature;
    return feel_temperature.toString();
  }

  String getLastUpdate() {
    var last_update = _last_update == null ? "NR" : _last_update;
    return last_update.toString();
  }

  String getId() {
    var id = _id == null ? "NR" : _id;
    return id.toString();
  }
}
