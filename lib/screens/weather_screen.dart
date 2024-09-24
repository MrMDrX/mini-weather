import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_weather/models/weather_model.dart';
import 'package:mini_weather/service/weather_service.dart';
import 'package:mini_weather/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService(apiKey: 'apiKey');
  Weather? _weather;

  _fetchWeather() async {
    try {
      final Position position = await _weatherService.getCurrentPosition();
      final weather = await _weatherService.getWeatherByCoordinates(
          position.latitude, position.longitude);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      setState(() {
        _weather = null;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unknown error occurred')),
      );
    }
  }

  static const Map<String, String> weatherAnimations = {
    'clear': 'assets/sunny.json',
    'clouds': 'assets/cloudy.json',
    'rain': 'assets/rainy.json',
    'drizzle': 'assets/rain.json',
    'thunderstorm': 'assets/thunder.json',
    'snow': 'assets/snowy.json',
    'mist': 'assets/cloudy.json',
  };

  String getWeatherAnimation(String condition) {
    return weatherAnimations[condition.toLowerCase()] ?? 'assets/sunny.json';
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
            title: Text('MINI WEATHER',
                style: TextStyle(
                    fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
                    letterSpacing: 2,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.light_mode_outlined, size: 32),
                    const SizedBox(width: 8),
                    Switch(
                        value: Provider.of<ThemeProvider>(context).isDarkMode,
                        onChanged: (value) {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        }),
                    const SizedBox(width: 8),
                    const Icon(Icons.dark_mode_outlined, size: 32),
                  ],
                ),
              )
            ]),
        body: Center(
          child: _weather == null
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _weather?.city.toUpperCase() ?? 'CITY..',
                      style: TextStyle(
                          fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
                          letterSpacing: 6,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Icon(Icons.location_on_outlined, size: 64),
                    Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: Lottie.asset(
                            getWeatherAnimation(_weather!.condition))),
                    Text(_weather?.condition ?? '',
                        style: TextStyle(
                            fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
                            fontSize: 32,
                            fontWeight: FontWeight.normal)),
                    const SizedBox(height: 16),
                    Text(
                      '${_weather?.temperature.round()}°C',
                      style: TextStyle(
                          fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
                          fontSize: 48,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
        ));
  }
}
