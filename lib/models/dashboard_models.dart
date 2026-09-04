import 'package:flutter/material.dart';

/// Kartu carousel "Sorotan Kota" di header dashboard.
class CitySpotlight {
  final String imageAsset;
  final String badgeLabel;
  final String tagLabel;
  final Color badgeColor;
  final String title;
  final String infoText;

  const CitySpotlight({
    required this.imageAsset,
    required this.badgeLabel,
    required this.tagLabel,
    required this.badgeColor,
    required this.title,
    required this.infoText,
  });
}

/// Item "Layanan Cepat Warga" (grid ikon kecil di bawah header).
class QuickService {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const QuickService({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.onTap,
  });
}

/// Item "Kategori Layanan Publik" (grid 2 kolom dengan ikon + deskripsi).
class ServiceCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const ServiceCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.onTap,
  });
}

/// Item berita pada section "Kabar Terkini Kota".
class NewsItem {
  final String imageAsset;
  // final String sourceLabel;
  final String title;
  final String timeAgo;
  final String category;

  const NewsItem({
    required this.imageAsset,
    // required this.sourceLabel,
    required this.title,
    required this.timeAgo,
    required this.category,
  });
}
