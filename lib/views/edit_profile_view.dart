import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Nama Pengguna',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'namapengguna@gmail.com',
  );
  final TextEditingController _phoneController = TextEditingController();

  String? _selectedGender;
  final List<String> _genderOptions = ['Laki-Laki', 'Perempuan'];

  static const double _headerHeight = 260.0;
  static const double _overlap = 32.0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ubah Foto Profil',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: const Text(
                'Ambil dari Kamera',
                style: TextStyle(fontSize: 12),
              ),
              onTap: () {
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColors.primary,
              ),
              title: const Text(
                'Pilih dari Galeri',
                style: TextStyle(fontSize: 12),
              ),
              onTap: () {
                Navigator.pop(ctx);
                // Tambahkan logika galeri (misal: image_picker)
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 1. HEADER DENGAN TENTANG/BACKGROUND & TOMBOL BACK
            SizedBox(
              height: _headerHeight,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('lib/assets/images/krb.jpeg', fit: BoxFit.cover),
                  Container(
                    color: const Color.fromARGB(
                      255,
                      6,
                      25,
                      57,
                    ).withOpacity(0.7),
                  ),
                  SafeArea(
                    child: Stack(
                      children: [
                        // Tombol Back (Batal Edit)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        // Profile Avatar + Icon Upload
                        Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
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
                              Positioned(
                                right: -4,
                                bottom: -4,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () =>
                                        _showImagePickerOptions(context),
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.add_a_photo,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. FORM EDIT PROFIL (KOTAK PUTIH)
            Padding(
              padding: const EdgeInsets.only(top: _headerHeight - _overlap),
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
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Field Nama Lengkap
                    _buildFieldLabel('Nama Lengkap Sesuai KTP'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _nameController,
                      decoration: _buildInputDecoration(
                        hintText: 'Masukkan Nama Lengkap...',
                        icon: Icons.badge_outlined,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field Email
                    _buildFieldLabel('Alamat Email'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _buildInputDecoration(
                        hintText: 'Masukkan Alamat Email...',
                        icon: Icons.email_outlined,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field Nomor Telepon
                    _buildFieldLabel('Nomor Telepon'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: _buildInputDecoration(
                        hintText: 'Masukkan Nomor Telepon...',
                        icon: Icons.phone_outlined,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Dropdown Jenis Kelamin
                    _buildFieldLabel('Jenis Kelamin'),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      hint: const Text(
                        'Pilih Jenis Kelamin...',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                      decoration: _buildInputDecoration(
                        hintText: '',
                        icon: Icons.wc_outlined,
                        style: const TextStyle(fontSize: 12),
                      ),
                      items: _genderOptions.map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(
                            gender,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 28),

                    // Tombol Simpan
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D1C2E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          // Simpan perubahan dan kembali ke halaman profil
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Ubah Profil',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  // Label Form Helper
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

  // Input Decoration Helper
  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
    required TextStyle style,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.grey, size: 20),
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
