import 'package:klima/services/location.dart';
import 'package:klima/services/networking.dart';

const apiKey = 'd1621c416aa0fb5fd6c59cbc9e0dc855';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Uri? url;

    url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'q': '$cityName',
        'appid': apiKey,
        'units': 'metric',
      },
    );

    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    double? latitude;
    double? longitude;
    Uri? url;

    Location location = Location();

    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'lat': '$latitude',
        'lon': '$longitude',
        'appid': apiKey,
        'units': 'metric',
      },
    );
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = await networkHelper.getData();

    // var temperature = weatherData['main']['temp'];
    // var city = weatherData['name'];
    // var id = weatherData['weather'][0]['id'];
    // print(city);
    // print('temperature: $temperature');
    // print(id);

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(var temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
