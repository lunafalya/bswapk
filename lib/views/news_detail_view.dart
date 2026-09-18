import 'package:flutter/material.dart';

/// Simple data model for a news article shown on [NewsDetailView].
class NewsArticle {
  const NewsArticle({
    required this.category,
    required this.categoryColor,
    required this.title,
    required this.isTrending,
    required this.timeAgo,
    required this.source,
    required this.paragraphs,
    required this.imageUrl,
    this.sourceAvatarUrl,
  });

  final String category;
  final Color categoryColor;
  final String title;
  final bool isTrending;
  final String timeAgo;
  final String source;
  final List<String> paragraphs;
  final String imageUrl;
  final String? sourceAvatarUrl;
}

class NewsDetailView extends StatelessWidget {
  const NewsDetailView({super.key, required this.article});

  final NewsArticle article;

  static const _navy = Color(0xFF0B2545);
  static const _blue = Color(0xFF1A56C4);

  static const double _heroHeight = 470;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(context),
                Transform.translate(
                  offset: const Offset(0, -28),
                  child: _buildBodyCard(),
                ),
              ],
            ),
          ),
          _buildBackButton(context),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildHero(BuildContext context) {
    return SizedBox(
      height: _heroHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            article.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: const Color(0xFFCFCFCF),
              child: const Icon(
                Icons.image_not_supported_outlined,
                size: 48,
                color: Colors.grey,
              ),
            ),
          ),
          // Darken the lower part of the photo so the title stays legible.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.35, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.75),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: article.categoryColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    article.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  article.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    if (article.isTrending) ...[
                      const Text(
                        'Trending',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    Text(
                      article.timeAgo,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 0, 0),
        child: Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyCard() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFFE0E0E0),
                backgroundImage: article.sourceAvatarUrl != null
                    ? NetworkImage(article.sourceAvatarUrl!)
                    : null,
              ),
              const SizedBox(width: 14),
              Text(
                article.source,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _navy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          for (final paragraph in article.paragraphs) ...[
            Text(
              paragraph,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 15.5,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 18),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            _NavBarItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isActive: false,
            ),
            _NavBarItem(
              icon: Icons.grid_view_rounded,
              label: 'Services',
              isActive: true,
              filled: true,
            ),
            _NavBarItem(icon: Icons.history, label: 'History', isActive: false),
            _NavBarItem(
              icon: Icons.notifications_none,
              label: 'Alerts',
              isActive: false,
            ),
            _NavBarItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    this.filled = false,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final bool filled;

  static const _navy = Color(0xFF0B2545);
  static const _blue = Color(0xFF1A56C4);

  @override
  Widget build(BuildContext context) {
    final color = isActive && !filled ? _blue : _navy;
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (filled && isActive)
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: _blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              )
            else
              Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? _blue : Colors.black54,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
