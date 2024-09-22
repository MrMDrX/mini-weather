import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Weather'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Weather'),
      ),
    );
  }
}
