import 'package:flutter/material.dart';
import '../models/wifi_hotspot.dart';
import '../theme/app_colors.dart';
import '../widgets/dummy_map_card.dart';
import '../widgets/wifi_hotspot_card.dart';

class WifiView extends StatefulWidget {
  const WifiView({super.key});

  @override
  State<WifiView> createState() => _WifiViewState();
}

class _WifiViewState extends State<WifiView> {
  bool _isConnected = false;
  String? _connectedNetworkName;

  // TODO: ganti dengan data dari API/backend + lokasi asli.
  final List<WifiHotspot> _hotspots = const [
    WifiHotspot(
      name: 'Taman Sempur Free WiFi',
      signal: WifiSignal.excellent,
      distance: '150m away',
      latitude: -6.5950,
      longitude: 106.7890,
    ),
    WifiHotspot(
      name: 'Perpustakaan Kota Bogor',
      signal: WifiSignal.good,
      distance: '320m away',
      latitude: -6.5960,
      longitude: 106.7910,
    ),
    WifiHotspot(
      name: 'Alun-Alun Kota',
      signal: WifiSignal.weak,
      distance: '850m away',
      isAvailable: false,
      latitude: -6.5975,
      longitude: 106.7935,
    ),
  ];

  void _handleConnect(WifiHotspot hotspot) {
    setState(() {
      _isConnected = true;
      _connectedNetworkName = hotspot.name;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Terhubung ke ${hotspot.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.onSurface,
        title: const Text(
          'Public WiFi',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const DummyMapCard(),
            const SizedBox(height: 16),
            _buildConnectionStatusCard(),
            const SizedBox(height: 24),
            const Text(
              'Nearby Hotspots',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.onSurface),
            ),
            const SizedBox(height: 12),
            for (final hotspot in _hotspots) ...[
              WifiHotspotCard(
                hotspot: hotspot,
                onConnect: () => _handleConnect(hotspot),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionStatusCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isConnected ? Icons.wifi : Icons.wifi_off,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isConnected ? 'Connected' : 'Not Connected',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.onSurface),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _isConnected
                          ? 'Anda terhubung ke $_connectedNetworkName'
                          : 'You are currently using cellular data.',
                      style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryContainer,
              foregroundColor: AppColors.onSurface,
              elevation: 0,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: const Text('Login to BSW WiFi'),
          ),
        ],
      ),
    );
  }
}
