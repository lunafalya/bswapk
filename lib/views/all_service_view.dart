import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_colors.dart';
import 'service_detail_view.dart';
import 'bpjs_view.dart';
import 'ppdb_view.dart';
import 'wifi_view.dart';
import 'cctv_view.dart';
import 'komunitas_view.dart';
import 'perizinan_view.dart';
import 'bansos_view.dart';
import 'rute_view.dart';
import 'berkas_view.dart';

class _ServiceItem {
  const _ServiceItem(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _ServiceCategory {
  const _ServiceCategory(this.title, this.color, this.items);

  final String title;
  final Color color;
  final List<_ServiceItem> items;
}

/// Halaman "Semua Layanan" — daftar lengkap layanan warga, dikelompokkan
/// per kategori (Kesehatan, Sosial, Pendidikan, dst), dibuka full-screen
/// dari tombol "Semua" pada grid Layanan Cepat Warga di HomeView.
///
/// Tiap kategori punya warna sendiri, dan tiap item saat ini navigate ke
/// [ServiceDetailView] generik — ganti dengan halaman layanan sesungguhnya
/// begitu tersedia.
class AllServicesView extends StatelessWidget {
  const AllServicesView({super.key});

  static const _categories = [
    _ServiceCategory('Kesehatan', Color(0xFFDC2626), [
      _ServiceItem('BPJS', Icons.medical_services),
      _ServiceItem('Mobile JKN', Icons.medical_services),
      _ServiceItem('Si Geulis', Icons.medical_services),
      _ServiceItem('Jamkesda', Icons.medical_services),
      _ServiceItem('RSUD Kota Bogor', Icons.medical_services),
    ]),
    _ServiceCategory('Sosial', Color(0xFFCA8A04), [
      _ServiceItem('Bansos', Icons.volunteer_activism),
      _ServiceItem('Komunitas', Icons.groups),
    ]),
    _ServiceCategory('Pendidikan', Color(0xFF2563EB), [
      _ServiceItem('PPDB', Icons.school),
      _ServiceItem('Komunitas', Icons.groups),
    ]),
    _ServiceCategory('Fasilitas & Transportasi', Color(0xFF16A34A), [
      _ServiceItem('Rute', Icons.directions_bus),
      _ServiceItem('CCTV', Icons.videocam),
      _ServiceItem('WIFI', Icons.wifi),
    ]),
    _ServiceCategory('Pemerintahan', Color(0xFF1F2937), [
      _ServiceItem('Perangkat Daerah', Icons.account_balance),
      _ServiceItem('Smart City', Icons.location_city),
      _ServiceItem('E-Kinerja', Icons.trending_up),
      _ServiceItem('Simpeg', Icons.badge),
    ]),
    _ServiceCategory('Pencatatan Sipil', Color(0xFFEA580C), [
      _ServiceItem('Perizinan', Icons.description),
      _ServiceItem('Berkas', Icons.folder),
    ]),
    _ServiceCategory('Pajak & Kepemilikan', Color(0xFF92400E), [
      _ServiceItem('Tagihan', Icons.payments),
      _ServiceItem('PBB', Icons.home_work),
      _ServiceItem('Aset', Icons.apartment),
    ]),
    _ServiceCategory('UMKM', Color(0xFFDB2777), [
      _ServiceItem('Tagihan', Icons.payments),
      _ServiceItem('PBB', Icons.home_work),
      _ServiceItem('Aset', Icons.apartment),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Layanan Cepat Warga',
          style: TextStyle(
            color: AppColors.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          for (final category in _categories) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                category.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: category.items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 4,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) => _ServiceTile(
                item: category.items[index],
                color: category.color,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.item, required this.color});

  final _ServiceItem item;
  final Color color;

  // Link web untuk item yang harus buka browser/app luar, bukan halaman
  // di dalam app. Tinggal tambah baris baru sesuai label item.
  static const _externalLinks = {
    'Mobile JKN': 'https://mobilejkn.bpjs-kesehatan.go.id',
    'Smart City': 'https://smartcity.kotabogor.go.id',
  };

  Future<void> _openExternalLink(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Tidak bisa membuka $url')));
    }
  }

  void _openDetail(BuildContext context) {
    // 1) Item dengan link web -> buka browser/app luar.
    final externalUrl = _externalLinks[item.label];
    if (externalUrl != null) {
      _openExternalLink(context, externalUrl);
      return;
    }

    // 2) Kalau item ini sudah punya halaman sendiri, arahkan ke situ.
    // Cukup tambah satu `case` baru di sini tiap kali halaman baru jadi —
    // nggak perlu ubah bagian lain di file ini. Contoh:
    //
    final Widget page;
    switch (item.label) {
      case 'BPJS':
        page = const BpjsView();
        break;
      case 'PPDB':
        page = const PpdbView();
        break;
      case 'WIFI':
        page = const WifiView();
        break;
      case 'CCTV':
        page = const CctvView();
        break;
      case 'Komunitas':
        page = const KomunitasView();
        break;
      case 'Perizinan':
        page = const PerizinanView();
        break;
      case 'Bansos':
        page = const BansosView();
        break;
      case 'rute':
        page = const RuteView();
        break;
      case 'Berkas':
        page = const BerkasView();
        break;
      default:
        page = ServiceDetailView(
          title: item.label,
          icon: item.icon,
          color: color,
        );
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            ServiceDetailView(title: item.label, icon: item.icon, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => _openDetail(context),
            child: SizedBox(
              width: 48,
              height: 48,
              child: Icon(item.icon, color: color, size: 22),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          item.label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
          ),
        ),
      ],
    );
  }
}
