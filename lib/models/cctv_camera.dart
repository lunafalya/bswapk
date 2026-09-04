/// Model untuk satu titik kamera CCTV.
class CctvCamera {
  final String name;
  final String location;
  final String? imageUrl;
  final bool isLive;

  const CctvCamera({
    required this.name,
    required this.location,
    this.imageUrl,
    this.isLive = true,
  });
}

/// Sekelompok kamera dalam satu kecamatan/area.
class CctvDistrict {
  final String name;
  final List<CctvCamera> cameras;

  const CctvDistrict({required this.name, required this.cameras});
}
