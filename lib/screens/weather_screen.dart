import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_weather/models/weather_model.dart';
import 'package:mini_weather/service/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService(apiKey: 'apikey');
  Weather? _weather;

  _fetchWeather() async {
    final Position position = await _weatherService.getCurrentPosition();
    // final String city = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeatherByCoordinates(
          position.latitude, position.longitude);
      // final weather = await _weatherService.getWeatherByCity(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  String getWeatherAnimation(String condition) {
    if (condition.toLowerCase() == 'clear') {
      return 'assets/sunny.json';
    } else if (condition.toLowerCase() == 'clouds') {
      return 'assets/cloudy.json';
    } else if (condition.toLowerCase() == 'rain') {
      return 'assets/rainy.json';
    } else if (condition.toLowerCase() == 'drizzle') {
      return 'assets/rain.json';
    } else if (condition.toLowerCase() == 'thunderstorm') {
      return 'assets/thunder.json';
    } else if (condition.toLowerCase() == 'snow') {
      return 'assets/snowy.json';
    } else if (condition.toLowerCase() == 'mist') {
      return 'assets/cloudy.json';
    } else {
      return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mini Weather'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _weather?.city ?? 'Loading City...',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Lottie.asset(getWeatherAnimation(_weather!.condition)),
              Text(_weather?.condition ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                  )),
              Text(
                '${_weather?.temperature}°C',
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
