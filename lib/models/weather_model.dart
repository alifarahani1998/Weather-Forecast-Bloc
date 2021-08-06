class Weather {
  String weatherCondition;
  String weatherDescription;
  double mainTemp;
  double minTemp;
  double maxTemp;
  int pressure;
  int humidity;

  Weather({this.weatherCondition, this.weatherDescription,
      this.mainTemp, this.minTemp, this.maxTemp, this.pressure, this.humidity});



  static Weather parseJson(dynamic json) {

    return Weather(
      weatherCondition: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      mainTemp: json['main']['temp'],
      minTemp: json['main']['temp_min'],
      maxTemp: json['main']['temp_max'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
    );
  }


  static String convertFahrenheitToCelsius(String temp) {
    double t = double.parse(temp);
    t = t - 273.15;
    return t.toStringAsFixed(2);
  }

}
