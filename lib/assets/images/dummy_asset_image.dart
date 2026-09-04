import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Widget gambar dari `lib/assets/...` dengan fallback placeholder rapi
/// jika file asset belum ditambahkan/didaftarkan di pubspec.yaml.
/// Ganti `assetPath` dengan gambar asli kapan pun sudah tersedia.
class DummyAssetImage extends StatelessWidget {
  final String assetPath;
  final BoxFit fit;
  final IconData placeholderIcon;

  const DummyAssetImage({
    super.key,
    required this.assetPath,
    this.fit = BoxFit.cover,
    this.placeholderIcon = Icons.image_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppColors.surfaceContainerHighest,
        alignment: Alignment.center,
        child: Icon(placeholderIcon, color: AppColors.outline, size: 28),
      ),
    );
  }
}
