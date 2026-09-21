import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'main_shell.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  static const _navy = Color(0xFF0B2545);
  static const _teal = Color(0xFF0E7C86);

  final PageController _carouselController = PageController(
    viewportFraction: 0.92,
  );
  int _currentPage = 0;

  final List<_NewsItem> _carouselItems = const [
    _NewsItem(
      category: 'Trasnport',
      title: 'Layanan biskita Trans Pakuan Bogor - Blok M kembali beroperasi',
      imageAsset: 'lib/assets/images/alun.jpg',
    ),
    _NewsItem(
      category: 'Aksi',
      title: 'Aksi warga Bogor terkait kebijakan baru pemerintah kota',
      imageAsset: 'lib/assets/images/alun.jpg',
    ),
    _NewsItem(
      category: 'Ekonomi',
      title: 'Perkembangan ekonomi kota Bogor triwulan ini',
      imageAsset: 'lib/assets/images/alun.jpg',
    ),
    _NewsItem(
      category: 'Gaya Hidup',
      title: 'Tren gaya hidup warga kota Bogor tahun ini',
      imageAsset: 'lib/assets/images/alun.jpg',
    ),
  ];

  final List<_RecommendationItem> _recommendations = const [
    _RecommendationItem(
      title: 'Judul Berita',
      description: 'Pemkot Bogor mengusulkan modifikasi cuaca dan pengerahan helikopter TNI AU untuk mengguyur air .....',
      imageAsset: 'lib/assets/images/alun.jpg',
    ),
    _RecommendationItem(
      title: 'Judul Berita',
      description: 'Pemkot Bogor mengusulkan modifikasi cuaca dan pengerahan helikopter TNI AU untuk mengguyur air .....',
      imageAsset: 'lib/assets/images/alun.jpg',
    ),
    _RecommendationItem(
      title: 'Judul Berita',
      description: 'Pemkot Bogor mengusulkan modifikasi cuaca dan pengerahan helikopter TNI AU untuk mengguyur air .....',
      imageAsset: 'lib/assets/images/alun.jpg',
    ),
  ];

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildBackButton(context)),
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(child: _buildCarousel()),
                SliverToBoxAdapter(child: _buildPageIndicator()),
                SliverToBoxAdapter(child: _buildRekomendasiHeading()),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                      child: _RecommendationCard(item: _recommendations[index]),
                    ),
                    childCount: _recommendations.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 90)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back, color: _navy, size: 28),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Berita Terkini',
            style:
                Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w800, color: _navy) ??
                const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: _navy,
                ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Temukan informasi terbaru, berita teraktual, dan laporan '
            'mendalam seputar peristiwa nasional, politik, ekonomi, '
            'hingga gaya hidup kota bogor',
            style: TextStyle(fontSize: 16, height: 1.4, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 200,
      width: 150,
      child: PageView.builder(
        controller: _carouselController,
        itemCount: _carouselItems.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          final item = _carouselItems[index];
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 8),
            child: _CarouselCard(item: item),
          );
        },
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_carouselItems.length, (index) {
          final bool isActive = index == _currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 22 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? _teal : const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRekomendasiHeading() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(24, 4, 24, 16),
      child: Text(
        'Rekomendasi',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: _navy,
        ),
      ),
    );
  }
}

class _NewsItem {
  const _NewsItem({
    required this.category,
    required this.title,
    required this.imageAsset,
  });

  final String category;
  final String title;
  final String imageAsset;
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({required this.item});

  final _NewsItem item;

  static const _navy = Color(0xFF0B2545);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            item.imageAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: const Color(0xFFE5E5E5),
              child: const Icon(
                Icons.image_not_supported_outlined,
                size: 40,
                color: Colors.grey,
              ),
            ),
          ),
          // Bottom gradient so the title stays readable over any photo.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, _navy.withValues(alpha: 0.85)],
                ),
              ),
              child: Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: _navy.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item.category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendationItem {
  const _RecommendationItem({
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  final String title;
  final String description;
  final String? imageAsset;
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({required this.item});

  final _RecommendationItem item;

  static const _navy = Color(0xFF0B2545);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 96,
              height: 96,
              child: item.imageAsset != null
                  ? Image.network(
                      item.imageAsset!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: const Color(0xFFE0E0E0)),
                    )
                  : Container(color: const Color(0xFFE0E0E0)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: _navy,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
