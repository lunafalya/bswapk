import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class AsetView extends StatelessWidget {
  const AsetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Aset', style: TextStyle(color: AppColors.onSurface)),
        iconTheme: const IconThemeData(color: AppColors.onSurface),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.apartment,
              size: 48,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            const Text(
              'Aset — konten belum tersedia',
              style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
