import 'package:flutter/material.dart';
import '../models/service_menu_item.dart';
import '../theme/app_colors.dart';

/// Satu item ikon layanan (mis. Utilities, Transit) yang dipakai di grid menu Home.
class ServiceMenuTile extends StatelessWidget {
  final ServiceMenuItem item;

  const ServiceMenuTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(32),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: item.backgroundColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surfaceContainerHighest),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
              ),
              child: Icon(item.icon, color: AppColors.primary, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
