class Weather {
  final String city;
  final String temperature;
  final String condition;

  Weather(
      {required this.city, required this.temperature, required this.condition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        city: json['name'],
        temperature: json['main']['temp'].toDouble(),
        condition: json['weather'][0]['main']);
  }
}
