import 'package:flutter/material.dart';

import '../models/dashboard_models.dart';
import '../theme/app_colors.dart';
import '../widgets/bsw_bottom_nav_bar.dart';
import '../widgets/city_spotlight_carousel.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/news_card.dart';
import '../widgets/quick_service_tile.dart';
import '../widgets/service_category_card.dart';
import '../widgets/weather_alert_card.dart';
import 'cctv_view.dart';
import 'wifi_view.dart';
import 'health_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentNavIndex = 0;

  // TODO: ganti seluruh data dummy di bawah ini dengan data dari API/backend.

  List<CitySpotlight> get _spotlights => const [
    CitySpotlight(
      imageAsset: 'lib/assets/images/alun.jpg',
      badgeLabel: 'Sorotan Kota',
      tagLabel: 'Alun-Alun',
      badgeColor: AppColors.primary,
      title: 'Revitalisasi Alun-Alun Kota Bogor Siap Diresmikan',
      infoText: 'Besok Pagi • Akses Publik',
    ),
    CitySpotlight(
      imageAsset: 'lib/assets/images/krb.jpeg',
      badgeLabel: 'Wisata & Edukasi',
      tagLabel: 'Kebun Raya',
      badgeColor: Color(0xFF00695C),
      title: 'Eksplorasi Keindahan & Konservasi Kebun Raya Bogor',
      infoText: 'Buka Setiap Hari • Tiket Online',
    ),
    CitySpotlight(
      imageAsset: 'lib/assets/images/biskita.jpg',
      badgeLabel: 'Transportasi Publik',
      tagLabel: 'BisKita',
      badgeColor: Color(0xFF1A5F7A),
      title: 'Rute Baru Biskita Trans Pakuan Koridor Terintegrasi',
      infoText: 'Tarif Terjangkau • Terjadwal',
    ),
  ];

  List<QuickService> get _quickServices => [
    QuickService(
      label: 'Utilities',
      icon: Icons.bolt,
      iconColor: AppColors.primary,
      backgroundColor: Colors.blue.shade50,
      onTap: () {},
    ),
    QuickService(
      label: 'Transit',
      icon: Icons.directions_bus,
      iconColor: const Color(0xFF2E7D32),
      backgroundColor: Colors.green.shade50,
      onTap: () {},
    ),
    QuickService(
      label: 'Perizinan',
      icon: Icons.description,
      iconColor: const Color(0xFFF57F17),
      backgroundColor: Colors.yellow.shade50,
      onTap: () {},
    ),
    QuickService(
      label: 'Kesehatan',
      icon: Icons.medical_services,
      iconColor: const Color(0xFFC62828),
      backgroundColor: Colors.red.shade50,
      onTap: () {
        //   Navigator.of(context)
        //       .push(MaterialPageRoute(builder: (_) => const HealthView()));
      },
    ),
    QuickService(
      label: 'WIFI',
      icon: Icons.wifi,
      iconColor: const Color(0xFF6A1B9A),
      backgroundColor: Colors.purple.shade50,
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const WifiView()));
      },
    ),
    QuickService(
      label: 'Tagihan',
      icon: Icons.payments,
      iconColor: const Color(0xFF283593),
      backgroundColor: Colors.indigo.shade50,
      onTap: () {},
    ),
    QuickService(
      label: 'CCTV',
      icon: Icons.videocam,
      iconColor: const Color(0xFF00695C),
      backgroundColor: Colors.teal.shade50,
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const CctvView()));
      },
    ),
    QuickService(
      label: 'Semua',
      icon: Icons.grid_view,
      iconColor: AppColors.onSurfaceVariant,
      backgroundColor: AppColors.surfaceContainerHigh,
      onTap: () {},
    ),
  ];

  List<ServiceCategory> get _categories => [
    ServiceCategory(
      title: 'Kesehatan',
      subtitle: 'RSUD, BPJS, Faskes',
      icon: Icons.health_and_safety,
      iconColor: const Color(0xFFC62828),
      backgroundColor: Colors.red.shade50,
      onTap: () {},
    ),
    ServiceCategory(
      title: 'Transportasi',
      subtitle: 'BisKita, Angkot, Rute',
      icon: Icons.directions_transit,
      iconColor: const Color(0xFF2E7D32),
      backgroundColor: Colors.green.shade50,
      onTap: () {},
    ),
    ServiceCategory(
      title: 'Pemerintahan',
      subtitle: 'Kelurahan, Regulasi',
      icon: Icons.account_balance,
      iconColor: AppColors.primary,
      backgroundColor: Colors.blue.shade50,
      onTap: () {},
    ),
    ServiceCategory(
      title: 'Kependudukan',
      subtitle: 'KTP, Akta, KK Online',
      icon: Icons.assignment_ind,
      iconColor: const Color(0xFF00695C),
      backgroundColor: Colors.teal.shade50,
      onTap: () {},
    ),
    ServiceCategory(
      title: 'Sosial & Warga',
      subtitle: 'Bansos, Komunitas',
      icon: Icons.groups,
      iconColor: const Color(0xFF6A1B9A),
      backgroundColor: Colors.purple.shade50,
      onTap: () {},
    ),
    ServiceCategory(
      title: 'UMKM & Usaha',
      subtitle: 'NIB, Pasar, Pajak',
      icon: Icons.storefront,
      iconColor: const Color(0xFF827717),
      backgroundColor: Colors.lime.shade50,
      onTap: () {},
    ),
    ServiceCategory(
      title: 'Pendidikan',
      subtitle: 'PPDB, Beasiswa',
      icon: Icons.school,
      iconColor: const Color(0xFF1565C0),
      backgroundColor: Colors.blue.shade50,
      onTap: () {},
    ),
    ServiceCategory(
      title: 'Hunian & PBB',
      subtitle: 'Tata Ruang, Retribusi',
      icon: Icons.home,
      iconColor: const Color(0xFFE65100),
      backgroundColor: Colors.orange.shade50,
      onTap: () {},
    ),
  ];

  List<NewsItem> get _news => const [
    NewsItem(
      imageAsset: 'lib/assets/images/pohontumbang.jpeg',
      // sourceLabel: 'BPBD',
      title: 'Sejumlah pohon tumbang akibat hujan dan angin lebat Senin',
      timeAgo: '2 jam lalu',
      category: 'Bencana',
    ),
    NewsItem(
      imageAsset: 'lib/assets/images/alun.jpg',
      // sourceLabel: 'Disparbud',
      title: 'Wisata ikonik Alun-alun kota bogor dekat stasiun bogor & surya kencana',
      timeAgo: '4 jam lalu',
      category: 'Wisata',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DashboardHeader(
                onSearchSubmitted: (query) {},
                onNotificationTap: () {},
                onProfileTap: () {},
              ),
              Transform.translate(
                offset: const Offset(0, -32),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTopBentoRow(),
                      const SizedBox(height: 20),
                      _buildQuickServicesSection(),
                      const SizedBox(height: 20),
                      _buildCategorySection(),
                      const SizedBox(height: 20),
                      _buildNewsSection(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom nav bar TETAP pakai yang lama (BswBottomNavBar).
      bottomNavigationBar: BswBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) => setState(() => _currentNavIndex = index),
      ),
    );
  }

  Widget _buildTopBentoRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;
        final weather = WeatherAlertCard(onMapTap: () {});
        final spotlight = CitySpotlightCarousel(spotlights: _spotlights);

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 7, child: weather),
              const SizedBox(width: 14),
              Expanded(flex: 5, child: spotlight),
            ],
          );
        }
        return Column(
          children: [weather, const SizedBox(height: 14), spotlight],
        );
      },
    );
  }

  Widget _buildQuickServicesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Layanan Cepat Warga',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              const Text(
                'Lihat Status Pengajuan',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _quickServices.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) =>
                QuickServiceTile(service: _quickServices[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 6,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Kategori Layanan Publik',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
            Text(
              '${_categories.length} Klaster',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.6,
          ),
          itemBuilder: (context, index) =>
              ServiceCategoryCard(category: _categories[index]),
        ),
      ],
    );
  }

  Widget _buildNewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 6,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E447B),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Kabar Terkini Kota',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
            const Text(
              'Semua Berita',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (final item in _news) ...[
          NewsCard(news: item, onTap: () {}),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
