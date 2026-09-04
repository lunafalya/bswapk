import 'package:flutter/material.dart';

import '../models/cctv_camera.dart';
import '../theme/app_colors.dart';
import '../widgets/cctv_camera_card.dart';

class CctvView extends StatefulWidget {
  const CctvView({super.key});

  @override
  State<CctvView> createState() => _CctvViewState();
}

class _CctvViewState extends State<CctvView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // TODO: ganti dengan data dari API/backend.
  List<CctvDistrict> get _districts => [
    CctvDistrict(
      name: 'Kecamatan Bogor Tengah',
      cameras: [
        const CctvCamera(
          name: 'Simpang Tugu Kujang',
          location: 'Jl. Pajajaran',
        ),
        const CctvCamera(name: 'Stasiun Bogor', location: 'Area Transit'),
        const CctvCamera(name: 'Balai Kota', location: 'Pusat Pemerintahan'),
        const CctvCamera(name: 'Jl. Sudirman', location: 'Jalan Utama'),
        for (int i = 5; i <= 16; i++)
          CctvCamera(name: 'Camera $i', location: 'Bogor Tengah'),
      ],
    ),
    CctvDistrict(
      name: 'Kecamatan Bogor Timur',
      cameras: [
        const CctvCamera(name: 'Pintu 1 Kebun Raya', location: 'Area Wisata'),
        for (int i = 2; i <= 16; i++)
          CctvCamera(name: 'Camera $i', location: 'Bogor Timur'),
      ],
    ),
  ];

  List<CctvDistrict> _filterDistricts(String query) {
    if (query.trim().isEmpty) return _districts;
    final lowerQuery = query.toLowerCase();
    return _districts
        .map((d) {
          final filteredCameras = d.cameras
              .where(
                (c) =>
                    c.name.toLowerCase().contains(lowerQuery) ||
                    c.location.toLowerCase().contains(lowerQuery) ||
                    d.name.toLowerCase().contains(lowerQuery),
              )
              .toList();
          return CctvDistrict(name: d.name, cameras: filteredCameras);
        })
        .where((d) => d.cameras.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.primary,
        title: const Text(
          'CCTV',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSearchBar(),
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: _searchController,
              builder: (context, _) {
                final districts = _filterDistricts(_searchController.text);
                if (districts.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        'Tidak ada kamera ditemukan.',
                        style: TextStyle(color: AppColors.onSurfaceVariant),
                      ),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final district in districts) ...[
                      _buildDistrictSection(district),
                      const SizedBox(height: 24),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: AppColors.onSurface),
        decoration: InputDecoration(
          hintText: 'Cari lokasi...',
          hintStyle: TextStyle(color: AppColors.outline.withOpacity(0.7)),
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(999),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDistrictSection(CctvDistrict district) {
    // Susun kamera menjadi 4 baris, kolom per kolom (meniru grid-flow-col di HTML).
    const rowCount = 4;
    final rows = List.generate(rowCount, (_) => <CctvCamera>[]);
    final columnCount = (district.cameras.length / rowCount).ceil();
    for (int c = 0; c < columnCount; c++) {
      for (int r = 0; r < rowCount; r++) {
        final index = c * rowCount + r;
        if (index < district.cameras.length) {
          rows[r].add(district.cameras[index]);
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          district.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height:
              4 * 88.0 +
              3 * 12.0, // 4 baris kartu (tinggi 88) + gap antar baris
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                for (int r = 0; r < rowCount; r++) ...[
                  Row(
                    children: [
                      for (final camera in rows[r]) ...[
                        CctvCameraCard(camera: camera),
                        const SizedBox(width: 12),
                      ],
                    ],
                  ),
                  if (r != rowCount - 1) const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
