# Mini Weather App

A minimal weather application built with Flutter that displays the current weather based on the user's location. The app supports light and dark themes and uses the OpenWeatherMap API to fetch weather data.

## Features

- Displays current weather based on GPS location.
- Supports light and dark themes.
- Animated weather conditions using Lottie animations.
- Simple and clean user interface.

## Screenshots

| **Dark Mode** | **Light Mode** |
| --- | --- |
| ![Dark Mode](https://github.com/MrMDrX/mini-weather/blob/main/images/screenshots/dark.png) | ![Light Mode](https://github.com/MrMDrX/mini-weather/blob/main/images/screenshots/light.png) |

## Technologies Used

- **Flutter**: The framework for building the app.
- **Dart**: The programming language used.
- **Lottie**: For animations.
- **Provider**: State management for theme and weather data.
- **Geolocator**: To get the device's current location.
- **HTTP**: For making API requests.

## Getting Started

### Prerequisites

- Flutter SDK installed on your machine.
- An API key from [OpenWeatherMap](https://openweathermap.org/api).

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/MrMDrX/mini-weather.git
   cd mini-weather
   ```

2. **Get dependencies:**

   ```bash
   flutter pub get
   ```

3. **Add your OpenWeatherMap API key:**

   Open the `lib/service/weather_service.dart` file and replace `'apiKey'` with your actual API key.

   ```dart
   final _weatherService = WeatherService(apiKey: 'YOUR_API_KEY_HERE');
   ```

4. **Run the app:**

   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue for any enhancements or bugs.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for details.