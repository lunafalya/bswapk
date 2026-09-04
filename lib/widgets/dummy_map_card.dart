import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Placeholder peta sementara untuk halaman WiFi.
/// TODO: ganti dengan google_maps_flutter / flutter_map + titik hotspot asli.
class DummyMapCard extends StatelessWidget {
  final String statusLabel;

  const DummyMapCard({super.key, this.statusLabel = 'Finding nearby networks...'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Stack(
        children: [
          // Dummy "peta": gradient + garis-garis samar meniru jalan.
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFD5E3FC), Color(0xFFEFF4FF)],
                ),
              ),
              child: CustomPaint(painter: _DummyMapPainter()),
            ),
          ),
          // Beberapa pin lokasi dummy.
          const Positioned(top: 40, left: 60, child: _MapPin()),
          const Positioned(top: 90, right: 70, child: _MapPin()),
          const Positioned(bottom: 60, left: 120, child: _MapPin()),
          Positioned(
            bottom: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.outlineVariant.withOpacity(0.2)),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.my_location, size: 16, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    statusLabel,
                    style: const TextStyle(fontSize: 13, color: AppColors.onSurface),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: const Icon(Icons.wifi, size: 14, color: Colors.white),
    );
  }
}

class _DummyMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 3;

    // Garis horizontal & vertikal samar meniru jalan pada peta dummy.
    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.35), paint);
    canvas.drawLine(Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.65), paint);
    canvas.drawLine(Offset(size.width * 0.25, 0), Offset(size.width * 0.3, size.height), paint);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.65, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
