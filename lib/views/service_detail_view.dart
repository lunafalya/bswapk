import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Halaman detail generik untuk satu layanan.
///
/// TODO: ini cuma placeholder — ganti dengan halaman layanan yang
/// sesungguhnya (mis. `BpjsView`, `PpdbView`, dst) begitu tersedia,
/// lalu arahkan `onTap` item terkait di `all_services_view.dart` ke sana.
class ServiceDetailView extends StatelessWidget {
  const ServiceDetailView({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(title, style: const TextStyle(color: AppColors.onSurface)),
        iconTheme: const IconThemeData(color: AppColors.onSurface),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              '$title — konten belum tersedia',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
