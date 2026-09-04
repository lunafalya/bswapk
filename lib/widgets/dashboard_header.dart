import 'package:flutter/material.dart';

/// Header hero dashboard: logo BSW, nama kota, tombol notifikasi/profil, search bar.
class DashboardHeader extends StatelessWidget {
  final String cityLabel;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onQrTap;
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onSearchSubmitted;
  final bool hasNotification;

  const DashboardHeader({
    super.key,
    this.cityLabel = 'Kota Bogor • Wilayah Tengah',
    this.onNotificationTap,
    this.onProfileTap,
    this.onQrTap,
    this.onFilterTap,
    this.onSearchSubmitted,
    this.hasNotification = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 48),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F3E7A), Color(0xFF005F9E)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 176,
              height: 176,
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: -30,
            child: Container(
              width: 144,
              height: 144,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 3),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'lib/assets/images/logobsw.jpg',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.apartment,
                              color: Color(0xFF00475E),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bogor Single Window',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cityLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.blue.shade100.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _HeaderIconButton(
                    icon: Icons.notifications_outlined,
                    showDot: hasNotification,
                    onTap: onNotificationTap,
                  ),
                  const SizedBox(width: 8),
                  _HeaderIconButton(
                    icon: Icons.account_circle_outlined,
                    onTap: onProfileTap,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildSearchBar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: TextField(
        onSubmitted: onSearchSubmitted,
        style: const TextStyle(fontSize: 14, color: Color(0xFF0D1C2E)),
        decoration: InputDecoration(
          hintText: 'Cari layanan publik, surat, fasilitas...',
          hintStyle: const TextStyle(color: Color(0xFF70787D), fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF00475E)),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.qr_code_scanner,
                  size: 20,
                  color: Color(0xFF70787D),
                ),
                onPressed: onQrTap,
              ),
              IconButton(
                icon: const Icon(
                  Icons.tune,
                  size: 20,
                  color: Color(0xFF70787D),
                ),
                onPressed: onFilterTap,
              ),
            ],
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final bool showDot;
  final VoidCallback? onTap;

  const _HeaderIconButton({
    required this.icon,
    this.showDot = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            if (showDot)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
