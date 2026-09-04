/// Kualitas sinyal WiFi hotspot.
enum WifiSignal { excellent, good, weak }

/// Model untuk satu titik WiFi publik.
class WifiHotspot {
  final String name;
  final WifiSignal signal;
  final String distance;
  final bool isAvailable;
  final double latitude;
  final double longitude;

  const WifiHotspot({
    required this.name,
    required this.signal,
    required this.distance,
    this.isAvailable = true,
    required this.latitude,
    required this.longitude,
  });
}
