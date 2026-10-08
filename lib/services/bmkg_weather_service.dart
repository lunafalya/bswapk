import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

// Set this to a real Bogor adm4 code (used when permission is denied
// or the user is outside Bogor).
const kDefaultAdm4 = '32.71.xx.xxxx';

class WeatherSlot {
  final DateTime time;
  final double temp;
  final int humidity;
  final String desc;
  final double windSpeed;
  final String windDir;

  WeatherSlot({
    required this.time,
    required this.temp,
    required this.humidity,
    required this.desc,
    required this.windSpeed,
    required this.windDir,
  });

  factory WeatherSlot.fromJson(Map<String, dynamic> j) => WeatherSlot(
    // "2025-05-01 07:00:00" -> parseable ISO string
    time: DateTime.parse(
      (j['local_datetime'] as String).replaceFirst(' ', 'T'),
    ),
    temp: (j['t'] as num).toDouble(),
    humidity: (j['hu'] as num).toInt(),
    desc: (j['weather_desc'] ?? '') as String,
    windSpeed: ((j['ws'] ?? 0) as num).toDouble(),
    windDir: (j['wd'] ?? '') as String,
  );
}

class WeatherData {
  final String area; // kelurahan name
  final WeatherSlot current;
  final double high;
  final double low;
  final WeatherSlot? tomorrow;

  WeatherData({
    required this.area,
    required this.current,
    required this.high,
    required this.low,
    this.tomorrow,
  });
}

class BmkgWeatherService {
  static const _base = 'https://api.bmkg.go.id/publik/prakiraan-cuaca';

  /// Full pipeline: permission -> nearest kelurahan -> BMKG -> WeatherData
  static Future<WeatherData> load() async {
    final adm4 = await _resolveAdm4();
    return fetch(adm4);
  }

  static Future<WeatherData> fetch(String adm4) async {
    final res = await http
        .get(Uri.parse('$_base?adm4=$adm4'))
        .timeout(const Duration(seconds: 10));
    if (res.statusCode != 200) {
      throw Exception('BMKG error ${res.statusCode}');
    }

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final area = (body['lokasi']?['desa'] ?? 'Bogor') as String;

    // data[0].cuaca = list of days, each day = list of 3-hourly slots
    final days = (body['data'][0]['cuaca'] as List)
        .map(
          (d) => (d as List)
              .map((s) => WeatherSlot.fromJson(s as Map<String, dynamic>))
              .toList(),
        )
        .toList();

    final all = days.expand((d) => d).toList();
    if (all.isEmpty) throw Exception('Data cuaca kosong');

    // Slot closest to now
    final now = DateTime.now();
    all.sort(
      (a, b) =>
          a.time.difference(now).abs().compareTo(b.time.difference(now).abs()),
    );
    final current = all.first;

    // High/low for the same day as the current slot
    final today = days.firstWhere(
      (d) => d.any((s) => _sameDay(s.time, current.time)),
      orElse: () => [current],
    );
    final temps = today.map((s) => s.temp);
    final high = temps.reduce((a, b) => a > b ? a : b);
    final low = temps.reduce((a, b) => a < b ? a : b);

    // Around midday tomorrow, if available
    final tmrwDay = days.where(
      (d) =>
          d.isNotEmpty &&
          d.first.time.isAfter(current.time) &&
          !_sameDay(d.first.time, current.time),
    );
    WeatherSlot? tomorrow;
    if (tmrwDay.isNotEmpty) {
      final d = tmrwDay.first;
      tomorrow = d.reduce(
        (a, b) => (a.time.hour - 13).abs() < (b.time.hour - 13).abs() ? a : b,
      );
    }

    return WeatherData(
      area: area,
      current: current,
      high: high,
      low: low,
      tomorrow: tomorrow,
    );
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  // ---------- location -> adm4 ----------

  static Future<String> _resolveAdm4() async {
    try {
      final pos = await _getPosition();
      if (pos == null) return kDefaultAdm4;

      final raw = await rootBundle.loadString('assets/bogor_kelurahan.json');
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();

      String? best;
      double bestDist = double.infinity;
      for (final k in list) {
        final d = Geolocator.distanceBetween(
          pos.latitude,
          pos.longitude,
          (k['lat'] as num).toDouble(),
          (k['lon'] as num).toDouble(),
        );
        if (d < bestDist) {
          bestDist = d;
          best = k['code'] as String;
        }
      }
      // If user is >15 km from any kelurahan, they're outside Bogor
      return (best != null && bestDist < 15000) ? best : kDefaultAdm4;
    } catch (_) {
      return kDefaultAdm4;
    }
  }

  static Future<Position?> _getPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;

    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getLastKnownPosition() ??
        await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.low,
          ),
        );
  }
}
