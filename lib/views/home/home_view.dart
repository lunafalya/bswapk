import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/dashboard_models.dart';
import '../../models/news_post.dart';
import '../../services/news_service.dart';
import '../news/news_detail_view.dart';
import '../../theme/app_colors.dart';
import '../../widgets/home/city_spotlight_carousel.dart';
import '../../widgets/home/dashboard_header.dart';
import '../../widgets/home/news_card.dart';
import '../../widgets/home/quick_service_tile.dart';
import '../../widgets/home/weather_alert_card.dart';
import '../facility/cctv_view.dart';
import '../facility/wifi_view.dart';
import '../service/all_service_view.dart';
import '../news/news_view.dart';
// Keep WeatherData ONLY from your new backend service
import '../service/weather_service.dart';

import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentNavIndex = 0;
  final NewsService _newsService = NewsService();
  late Future<List<NewsPost>> _newsFuture;
  late Future<WeatherData> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = _newsService.fetchNews();
    _weatherFuture = WeatherService.fetchWeather();
  }

  void dispose() {
    _newsService.dispose();
    super.dispose();
  }

  void _reloadWeather() {
    setState(() {
      _weatherFuture = WeatherService.fetchWeather();
    });
  }

  IconData _iconFor(String desc) {
    final d = desc.toLowerCase();

    // Thunderstorm / Petir
    if (d.contains('petir') || d.contains('thunder') || d.contains('storm')) {
      return Icons.thunderstorm_rounded;
    }

    // Rain / Hujan / Drizzle / Showers
    if (d.contains('hujan') ||
        d.contains('rain') ||
        d.contains('drizzle') ||
        d.contains('shower')) {
      return Icons.water_drop_rounded;
    }

    // Cloudy / Berawan / Overcast
    if (d.contains('berawan') ||
        d.contains('cloud') ||
        d.contains('overcast')) {
      return Icons.cloud_rounded;
    }

    // Fog / Mist / Haze / Kabut
    if (d.contains('kabut') ||
        d.contains('asap') ||
        d.contains('fog') ||
        d.contains('mist')) {
      return Icons.foggy;
    }

    // Sunny / Clear / Cerah
    return Icons.wb_sunny_rounded;
  }

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
      label: 'Rute',
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
      label: 'BPJS',
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
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => const AllServicesView(),
          ),
        );
      },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Uri whatsappUrl = Uri.parse("https://wa.me/6281122882233");
          try {
            final launched = await launchUrl(
              whatsappUrl,
              mode: LaunchMode.externalApplication,
            );
            if (!launched) {
              throw 'Could not launch $whatsappUrl';
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Tidak dapat membuka WhatsApp")),
            );
          }
        },
        backgroundColor: const Color.fromRGBO(30, 68, 123, 1),
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  Widget _weatherCard() {
    return FutureBuilder<WeatherData>(
      future: _weatherFuture,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 160,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snap.hasError || !snap.hasData) {
          return WeatherAlertCard(
            temperature: '--°',
            weatherLabel: 'Gagal memuat cuaca',
            highLow: '',
            aqiValue: '--',
            humidity: '--',
            onMapTap: _reloadWeather,
          );
        }

        final w = snap.data!;
        final desc = w.conditionText;
        final dynamicIcon = _iconFor(desc);

        return WeatherAlertCard(
          temperature: '${w.currentTemp.round()}°',
          weatherLabel: desc.isNotEmpty ? desc : 'Cerah Berawan',
          highLow: 'H: ${w.besokTinggi.round()}° L: ${w.besokRendah.round()}°',
          aqiLabel: 'Besok',
          aqiValue: '${w.besokTinggi.round()}° / ${w.besokRendah.round()}°',
          humidity: '--',
          icon: dynamicIcon, // Pass the dynamic icon here
          onMapTap: () {},
        );
      },
    );
  }

  Widget _buildTopBentoRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;
        final weather = _weatherCard();
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
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const NewsView()));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerRight,
              ),
              child: const Text(
                'Semua Berita',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<NewsPost>>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    const Text('Gagal memuat berita'),
                    TextButton(
                      onPressed: () => setState(() {
                        _newsFuture = _newsService.fetchNews();
                      }),
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            }
            final posts = (snapshot.data ?? const <NewsPost>[])
                .take(3)
                .toList();
            if (posts.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: Text('Belum ada berita')),
              );
            }
            return Column(
              children: [
                for (final post in posts) ...[
                  NewsCard(
                    news: post,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            NewsDetailView(article: NewsArticle.fromPost(post)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
