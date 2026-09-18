import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class DataView extends StatefulWidget {
  const DataView({super.key});

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _kkController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController(
    text: '00/00/0000',
  );
  final TextEditingController _bpjsController = TextEditingController();
  final TextEditingController _npwpController = TextEditingController();
  final TextEditingController _pasporController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  String? _selectedStatus;
  final List<String> _statusOptions = [
    'Menikah',
    'Belum Menikah',
    'Duda',
    'Janda',
  ];

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
    _nikController.dispose();
    _kkController.dispose();
    _tempatLahirController.dispose();
    _tanggalLahirController.dispose();
    _bpjsController.dispose();
    _npwpController.dispose();
    _pasporController.dispose();
    _pekerjaanController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  // Fungsi untuk kembali dengan animasi slide down halus
  void _handleBack() async {
    await _animController.reverse(); // Form meluncur turun dulu
    if (mounted) {
      Navigator.of(context).pop(); // Lalu halaman ditutup
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2003, 4, 3),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
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
                          'Data Diri',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D1C2E),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Lengkapi data diri Anda di bawah ini untuk memudahkan proses layanan bsw',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF718096),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Form Inputs
                        _buildFieldLabel('Nomor Induk Kependudukan (NIK)'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _nikController,
                          keyboardType: TextInputType.number,
                          decoration: _buildInputDecoration(
                            hintText: '16 Digit NIK Anda',
                            icon: Icons.badge_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildFieldLabel('No KK'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _kkController,
                          keyboardType: TextInputType.number,
                          decoration: _buildInputDecoration(
                            hintText: 'Masukkan Nomor Kartu Keluarga',
                            icon: Icons.badge_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildFieldLabel('Tempat Lahir'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _tempatLahirController,
                          decoration: _buildInputDecoration(
                            hintText: 'Masukkan Tempat Lahir Anda',
                            icon: Icons.location_on_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildFieldLabel('Tanggal Lahir'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _tanggalLahirController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: _buildInputDecoration(
                            hintText: 'dd/mm/yyyy',
                            icon: Icons.calendar_today_outlined,
                            suffixIcon: const Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildFieldLabel('Nomor BPJS'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _bpjsController,
                          decoration: _buildInputDecoration(
                            hintText: 'Masukkan Nomor BPJS',
                            icon: Icons.email_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildFieldLabel('NPWP'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _npwpController,
                          decoration: _buildInputDecoration(
                            hintText: 'Masukkan Nomor NPWP',
                            icon: Icons.subtitles_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildFieldLabel('Nomor Paspor'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _pasporController,
                          decoration: _buildInputDecoration(
                            hintText: 'Masukkan Nomor Paspor',
                            icon: Icons.menu_book_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildFieldLabel('Pekerjaan'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _pekerjaanController,
                          decoration: _buildInputDecoration(
                            hintText: 'Masukkan Pekerjaan',
                            icon: Icons.work_outline,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildFieldLabel('Alamat'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _alamatController,
                          decoration: _buildInputDecoration(
                            hintText: 'Masukkan Alamat',
                            icon: Icons.home_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildFieldLabel('Status Perkawinan'),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          items: _statusOptions.map((status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedStatus = newValue;
                            });
                          },
                          decoration: _buildInputDecoration(
                            hintText: 'Pilih Status Perkawinan',
                            icon: Icons.people_outline,
                          ),
                        ),

                        const SizedBox(height: 24),
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
                              'Simpan Perubahan',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
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
