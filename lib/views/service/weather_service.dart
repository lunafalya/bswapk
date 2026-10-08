import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherData {
  final double currentTemp;
  final String conditionText; // Added field
  final double besokRendah;
  final double besokTinggi;
  final double lusaRendah;
  final double lusaTinggi;
  final String iconHariIni;
  final String iconBesok;
  final String iconLusa;

  WeatherData({
    required this.currentTemp,
    required this.conditionText,
    required this.besokRendah,
    required this.besokTinggi,
    required this.lusaRendah,
    required this.lusaTinggi,
    required this.iconHariIni,
    required this.iconBesok,
    required this.iconLusa,
  });

  factory WeatherData.fromWeatherApi(Map<String, dynamic> json) {
    String fixUrl(String? url) {
      if (url == null || url.isEmpty) return '';
      return url.startsWith('//') ? 'https:$url' : url;
    }

    final current = json['current'] ?? {};
    final forecastList = (json['forecast']?['forecastday'] as List?) ?? [];

    final today = forecastList.isNotEmpty ? forecastList[0]['day'] : null;
    final tomorrow = forecastList.length > 1 ? forecastList[1]['day'] : null;
    final dayAfter = forecastList.length > 2 ? forecastList[2]['day'] : null;

    return WeatherData(
      currentTemp: (current['temp_c'] as num?)?.toDouble() ?? 0.0,
      conditionText:
          current['condition']?['text'] ?? '', // Extract text description
      besokRendah: (tomorrow?['mintemp_c'] as num?)?.toDouble() ?? 0.0,
      besokTinggi: (tomorrow?['maxtemp_c'] as num?)?.toDouble() ?? 0.0,
      lusaRendah: (dayAfter?['mintemp_c'] as num?)?.toDouble() ?? 0.0,
      lusaTinggi: (dayAfter?['maxtemp_c'] as num?)?.toDouble() ?? 0.0,
      iconHariIni: fixUrl(current['condition']?['icon']),
      iconBesok: fixUrl(tomorrow?['condition']?['icon']),
      iconLusa: fixUrl(dayAfter?['condition']?['icon']),
    );
  }
}

class WeatherService {
  static const String _apiKey = '9b9297c331cf43beb5a31851231306';

  static Future<WeatherData> fetchWeather({
    double lat = -6.5952606,
    double lng = 106.7935671,
  }) async {
    final url = Uri.parse(
      'https://api.weatherapi.com/v1/forecast.json?key=$_apiKey&q=$lat,$lng&days=3&aqi=no&alerts=no',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return WeatherData.fromWeatherApi(data);
    } else {
      throw Exception(
        'Failed to fetch weather from WeatherAPI: ${response.statusCode}',
      );
    }
  }
}
