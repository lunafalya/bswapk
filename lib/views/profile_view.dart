import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'about_us_view.dart';
import 'data_view.dart';
import 'help_view.dart';
import 'password_view.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
    this.userName = 'Nama Pengguna',
    this.userEmail = 'namapengguna@gmail.com',
  });

  final String userName;
  final String userEmail;

  static const _overlap = 32.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Header Profile
            _ProfileHeader(userName: userName, userEmail: userEmail),

            // Bagian Menu
            Padding(
              padding: const EdgeInsets.only(
                top: _ProfileHeader.height - _overlap,
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(66, 198, 150, 150),
                      blurRadius: 4,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ProfileMenuTile(
                      icon: Icons.privacy_tip_outlined,
                      label: 'Data Diri',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const DataView()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _ProfileMenuTile(
                      icon: Icons.lock_outline,
                      label: 'Kata Sandi',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const PasswordView(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _ProfileMenuTile(
                      icon: Icons.help_outline,
                      label: 'Bantuan',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const HelpView()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _ProfileMenuTile(
                      icon: Icons.contact_page_outlined,
                      label: 'Tentang Kami',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AboutUsView(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _ProfileMenuTile(
                      icon: Icons.logout,
                      label: 'Keluar',
                      color: AppColors.error,
                      showArrow: false,
                      onTap: () => _confirmLogout(context),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Versi Aplikasi 123.456.78',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text(
              'Keluar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.userName, required this.userEmail});

  void _showProfileImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Konten Pop-up Foto
              Container(
                width: 260,
                height: 260,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 180,
                  color: Color(0xFF0D1C2E),
                ),
              ),

              // Tombol Tutup/Close di kanan atas
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final String userName;
  final String userEmail;

  static const double height = 289;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('lib/assets/images/krb.jpeg', fit: BoxFit.cover),
          Container(
            color: const Color.fromARGB(255, 6, 25, 57).withOpacity(0.7),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // 1. FOTO PROFIL (Bisa diklik untuk Pop-up)
                    GestureDetector(
                      onTap: () => _showProfileImageDialog(context),
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 70,
                          color: Color(0xFF0D1C2E),
                        ),
                      ),
                    ),

                    Positioned(
                      right: -4,
                      bottom: -4,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const EditProfileView(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  userName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  userEmail,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
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

class _ProfileMenuTile extends StatelessWidget {
  const _ProfileMenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = AppColors.onSurface,
    this.showArrow = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: color == AppColors.error ? color : AppColors.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            if (showArrow)
              const Icon(
                Icons.chevron_right,
                size: 21,
                color: Color(0xFF9AA5AD),
              ),
          ],
        ),
      ),
    );
  }
}
