import 'package:flutter/material.dart';

/// Model untuk satu item layanan pada grid menu utama (mis. Utilities, Transit, dll)
class ServiceMenuItem {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const ServiceMenuItem({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    this.onTap,
  });
}
