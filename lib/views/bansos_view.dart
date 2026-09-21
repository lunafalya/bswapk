import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BansosView extends StatelessWidget {
  const BansosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Tentang Kami',
          style: TextStyle(color: AppColors.onSurface),
        ),
        iconTheme: const IconThemeData(color: AppColors.onSurface),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.contact_page_outlined,
              size: 48,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            const Text(
              'Tentang Kami — konten belum tersedia',
              style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
