import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';

/// Satu ikon "Layanan Cepat Warga" (grid 4x2).
class QuickServiceTile extends StatelessWidget {
  final QuickService service;

  const QuickServiceTile({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: service.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: service.backgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
              ),
              child: Icon(service.icon, color: service.iconColor, size: 24),
            ),
            const SizedBox(height: 6),
            Text(
              service.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF0D1C2E)),
            ),
          ],
        ),
      ),
    );
  }
}
