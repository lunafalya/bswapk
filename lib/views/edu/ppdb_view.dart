import 'package:flutter/material.dart';

import '../../models/ppdb_models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/ppdb/level_filter_chip.dart';
import '../../widgets/ppdb/school_registration_card.dart';

class PpdbView extends StatefulWidget {
  const PpdbView({super.key});

  @override
  State<PpdbView> createState() => _ppdbViewState();
}

class _ppdbViewState extends State<PpdbView> {
  final _searchController = TextEditingController();
  SchoolLevel _selectedLevel = SchoolLevel.sd;

  int _currentNavIndex = 1;

  // TODO: ganti dengan data dari API/backend sesuai _selectedLevel & hasil "Cek".
  late final List<SchoolRegistration> _schools = List.generate(
    4,
    (_) => const SchoolRegistration(
      level: SchoolLevel.sd,
      name: 'SDN 01 Bogor',
      code: '3135327321047634',
      location: 'Bogor Tengah',
      headmasterName: 'Nama Kepala Sekolah',
      address: 'Ruko Blok BII No. 9–10, Cluster Amparan Jati, Pakuan Regency, Kota Bogor',
      infoPeriodLabel: '3 bulan sekali',
      timelineRemainingLabel: '4 Minggu lagi',
      steps: [
        PpdbStep(label: 'Distribusi Akun Pendaftaran', isActive: true),
        PpdbStep(label: 'Pengisian Biodata dan Informasi Umum'),
        PpdbStep(label: 'Pemilihan Jalur dan Satuan Pendidikan Tujuan'),
        PpdbStep(label: 'Verifikasi Data'),
        PpdbStep(label: 'Pengesahan Seleksi'),
        PpdbStep(label: 'Pengumuman'),
        PpdbStep(label: 'Daftar Ulang'),
      ],
    ),
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleCek() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Mencari sekolah "${_searchController.text}" untuk jenjang ${_selectedLevel.label}...',
        ),
      ),
    );
  }

  void _handleRegister(SchoolRegistration school) {
    // TODO: arahkan ke alur pendaftaran sebenarnya.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Membuka pendaftaran untuk ${school.name}...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                children: [
                  const Text(
                    'Sistem Penerimaan Murid Baru (SPMB)',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pengumuman pembukaan jalur pendaftaran, sambutan, serta jadwal penting.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.onSurfaceVariant,
                      height: 20 / 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLevelTabs(),
                  const SizedBox(height: 16),
                  _buildSearchField(),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleCek,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF142450),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.7,
                        ),
                      ),
                      child: const Text('Cek'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (final school in _schools) ...[
                    SchoolRegistrationCard(
                      school: school,
                      onRegister: () => _handleRegister(school),
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelTabs() {
    return Row(
      children: [
        for (final level in SchoolLevel.values) ...[
          LevelFilterChip(
            label: level.label,
            isActive: _selectedLevel == level,
            onTap: () => setState(() => _selectedLevel = level),
          ),
          if (level != SchoolLevel.values.last) const SizedBox(width: 26),
        ],
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: AppColors.onSurface, fontSize: 16),
        decoration: InputDecoration(
          hintText: 'Cari lokasi...',
          hintStyle: TextStyle(color: AppColors.outline.withOpacity(0.7)),
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(999),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
