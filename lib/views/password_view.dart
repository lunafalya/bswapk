import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Animasi kurva halus (easeOutCubic saat muncul)
    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 1), // Mulai dari luar layar bawah
          end: Offset.zero, // Berhenti di posisi normal
        ).animate(
          CurvedAnimation(
            parent: _animController,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        );

    // Jalankan animasi saat halaman dimuat
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Fungsi untuk kembali dengan animasi slide down halus
  void _handleBack() async {
    await _animController.reverse(); // Form meluncur turun dulu
    if (mounted) {
      Navigator.of(context).pop(); // Lalu halaman ditutup
    }
  }

  @override
  Widget build(BuildContext context) {
    // PopScope menangani jika pengguna menekan tombol back fisik HP
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _handleBack();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent, // Latar belakang transparan
        body: Stack(
          children: [
            // 1. Tombol Back di Pojok Atas (Menempel di atas Header Profile)
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _handleBack,
                  ),
                ),
              ),
            ),

            // 2. Hanya Form Putih ini yang Beranimasi Naik & Turun
            SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(66, 198, 150, 150),
                        blurRadius: 6,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ubah Kata Sandi',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D1C2E),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Masukkan email Anda untuk mengubah kata sandi.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF718096),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Form Inputs
                        _buildFieldLabel('Email'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _buildInputDecoration(
                            hintText: 'Masukkan Email Anda',
                            icon: Icons.email_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4A5568),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.grey, size: 20),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}
