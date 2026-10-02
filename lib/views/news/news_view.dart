import 'package:flutter/material.dart';

import '../../models/news_post.dart';
import '../../services/news_service.dart';
import 'news_detail_view.dart';

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

  final NewsService _newsService = NewsService();
  late Future<List<NewsPost>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = _newsService.fetchNews();
  }

  @override
  void dispose() {
    _carouselController.dispose();
    _newsService.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    setState(() {
      _newsFuture = _newsService.fetchNews();
    });
    await _newsFuture;
  }

  void _openDetail(NewsPost post) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsDetailView(article: _toArticle(post)),
      ),
    );
  }

  /// Ubah [NewsPost] (field API) jadi [NewsArticle] (dipakai NewsDetailView).
  NewsArticle _toArticle(NewsPost post) {
    return NewsArticle(
      category:
          'Berita', // API tidak punya field kategori — sesuaikan kalau ada.
      categoryColor: _navy,
      title: post.judul,
      isTrending: false,
      timeAgo: post.timeAgo,
      source: 'Pemerintah Kota Bogor', // API tidak punya nama penulis/sumber.
      paragraphs: post.paragraphs,
      imageUrl: post.imageUrl ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<NewsPost>>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return _buildError(snapshot.error.toString());
            }

            final posts = snapshot.data ?? const [];
            if (posts.isEmpty) {
              return _buildEmpty();
            }

            // 4 berita pertama untuk carousel unggulan, sisanya untuk
            // daftar rekomendasi. Sesuaikan pembagiannya kalau perlu.
            final carouselPosts = posts.take(4).toList();
            final recommendedPosts = posts.skip(carouselPosts.length).toList();

            return RefreshIndicator(
              onRefresh: _reload,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildBackButton(context)),
                  SliverToBoxAdapter(child: _buildHeader(context)),
                  SliverToBoxAdapter(child: _buildCarousel(carouselPosts)),
                  SliverToBoxAdapter(
                    child: _buildPageIndicator(carouselPosts.length),
                  ),
                  SliverToBoxAdapter(child: _buildRekomendasiHeading()),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                        child: _RecommendationCard(
                          post: recommendedPosts[index],
                          onTap: () => _openDetail(recommendedPosts[index]),
                        ),
                      ),
                      childCount: recommendedPosts.length,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 90)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 40, color: Colors.grey),
            const SizedBox(height: 12),
            Text('Gagal memuat berita: $message', textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _reload, child: const Text('Coba Lagi')),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.article_outlined, size: 40, color: Colors.grey),
          SizedBox(height: 12),
          Text('Belum ada berita'),
        ],
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

  Widget _buildHeader(BuildContext context) {
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

  Widget _buildCarousel(List<NewsPost> posts) {
    if (posts.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _carouselController,
        itemCount: posts.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          final post = posts[index];
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 8),
            child: _CarouselCard(post: post, onTap: () => _openDetail(post)),
          );
        },
      ),
    );
  }

  Widget _buildPageIndicator(int count) {
    if (count <= 1) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (index) {
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

/// Tampilkan gambar berita dengan fallback placeholder kalau `imageUrl`
/// null atau gagal dimuat — dipakai di carousel & recommendation card.
Widget _newsImage(String? imageUrl, {required BoxFit fit}) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return Container(
      color: const Color(0xFFE5E5E5),
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: 40,
        color: Colors.grey,
      ),
    );
  }
  return Image.network(
    imageUrl,
    fit: fit,
    errorBuilder: (context, error, stackTrace) => Container(
      color: const Color(0xFFE5E5E5),
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: 40,
        color: Colors.grey,
      ),
    ),
  );
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({required this.post, required this.onTap});

  final NewsPost post;
  final VoidCallback onTap;

  static const _navy = Color(0xFF0B2545);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _newsImage(post.imageUrl, fit: BoxFit.cover),
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
                    colors: [Colors.transparent, _navy.withOpacity(0.85)],
                  ),
                ),
                child: Text(
                  post.judul,
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
          ],
        ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({required this.post, required this.onTap});

  final NewsPost post;
  final VoidCallback onTap;

  static const _navy = Color(0xFF0B2545);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
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
                child: _newsImage(post.imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.judul,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _navy,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    post.ringkas,
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
      ),
    );
  }
}
