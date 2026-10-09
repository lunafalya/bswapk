import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_colors.dart';
import 'service_detail_view.dart';
import '../health/bpjs_view.dart';
import '../edu/ppdb_view.dart';
import '../facility/wifi_view.dart';
import '../facility/cctv_view.dart';
import '../social/komunitas_view.dart';
import '../civil/perizinan_view.dart';
import '../social/bansos_view.dart';
import '../facility/rute_view.dart';
import '../civil/berkas_view.dart';
import '../tax/tagihan_view.dart';
import '../gov/perangkat_daerah_view.dart';
import '../tax/pbb_view.dart';
import '../tax/aset_view.dart';

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
      _ServiceItem('Usaha', Icons.work),
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
    'Mobile JKN': 'https://jknmobile.com/',
    'Smart City': 'https://smartcity.kotabogor.go.id',
    'Si Geulis': 'https://sigeulis.kotabogor.go.id/',
    'Jamkesda': 'https://dikaper-v1.kotabogor.go.id/',
    'RSUD Kota Bogor': 'https://rsudkotabogor.com/',
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

    // 2) Item dengan halaman sendiri di dalam app.
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
      case 'Rute':
        page = const RuteView();
        break;
      case 'Berkas':
        page = const BerkasView();
        break;
      case 'Perangkat Daerah':
        page = const PerangkatDaerahView();
        break;
      case 'Tagihan':
        page = const TagihanView();
        break;
      case 'PBB':
        page = const PbbView();
        break;
      case 'Aset':
        page = const AsetView();
        break;
      default:
        // Belum ada halaman khusus -> placeholder generik.
        page = ServiceDetailView(
          title: item.label,
          icon: item.icon,
          color: color,
        );
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
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
