import 'package:flutter/material.dart';
import '../models/wifi_hotspot.dart';
import '../theme/app_colors.dart';

/// Kartu satu titik hotspot WiFi: ikon, nama, kualitas sinyal, jarak, tombol Connect.
class WifiHotspotCard extends StatelessWidget {
  final WifiHotspot hotspot;
  final VoidCallback? onConnect;

  const WifiHotspotCard({super.key, required this.hotspot, this.onConnect});

  String get _signalLabel {
    switch (hotspot.signal) {
      case WifiSignal.excellent:
        return 'Excellent';
      case WifiSignal.good:
        return 'Good';
      case WifiSignal.weak:
        return 'Weak';
    }
  }

  IconData get _signalIcon {
    switch (hotspot.signal) {
      case WifiSignal.excellent:
        return Icons.signal_cellular_alt;
      case WifiSignal.good:
        return Icons.signal_cellular_alt_2_bar;
      case WifiSignal.weak:
        return Icons.signal_cellular_alt_1_bar;
    }
  }

  Color get _signalColor {
    switch (hotspot.signal) {
      case WifiSignal.excellent:
        return AppColors.primary;
      case WifiSignal.good:
      case WifiSignal.weak:
        return AppColors.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: hotspot.isAvailable ? 1 : 0.75,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi,
                color: hotspot.isAvailable ? AppColors.primary : AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotspot.name,
                    style: const TextStyle(fontSize: 16, color: AppColors.onSurface),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(_signalIcon, size: 14, color: _signalColor),
                      const SizedBox(width: 4),
                      Text(
                        _signalLabel,
                        style: TextStyle(fontSize: 13, color: _signalColor),
                      ),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: AppColors.outlineVariant)),
                      const SizedBox(width: 8),
                      Text(
                        hotspot.distance,
                        style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: onConnect,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    hotspot.isAvailable ? AppColors.primary : AppColors.surfaceContainerHigh,
                foregroundColor:
                    hotspot.isAvailable ? Colors.white : AppColors.onSurfaceVariant,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
