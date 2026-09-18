import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Halaman "Data Diri".
/// TODO: isi dengan form/tampilan data diri pengguna sesungguhnya.
class DataView extends StatelessWidget {
  const DataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Data Diri',
          style: TextStyle(color: AppColors.onSurface),
        ),
        iconTheme: const IconThemeData(color: AppColors.onSurface),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.privacy_tip_outlined,
              size: 48,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            const Text(
              'Data Diri — konten belum tersedia',
              style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
