import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_colors.dart';

class _Official {
  const _Official(this.name, this.title, this.imagePath);
  final String name;
  final String title;
  final String imagePath;
}

class _AgencyContact {
  const _AgencyContact({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.websiteUrl,
    required this.imagePath,
  });

  final String name;
  final String email;
  final String phone;
  final String address;
  final String websiteUrl;
  final String imagePath;
}

class PerangkatDaerahView extends StatelessWidget {
  const PerangkatDaerahView({super.key});

  static const _officials = [
    _Official(
      'Dedie A Rachim',
      'Walikota Bogor',
      'lib/assets/images/dedie.jpg',
    ),
    _Official(
      'Jenal Mutaqin',
      'Wakil Walikota Bogor',
      'lib/assets/images/jenal.jpg',
    ),
  ];

  static const _agencies = [
    _AgencyContact(
      name: 'Sekretariat Daerah',
      email: 'setda@kotabogor.go.id',
      phone: '(0251) 8324021',
      address: 'Jl. Ir. H. Juanda No.10, RT.01/RW.01, Pabaton',
      websiteUrl: 'https://setda.kotabogor.go.id',
      imagePath: 'lib/assets/images/setda.jpg',
    ),
    _AgencyContact(
      name: 'Sekretariat DPRD',
      email: 'setwan@kotabogor.go.id',
      phone: '(0251) 8324021',
      address: 'Jl. Pemuda No.25, RT.01/RW.06, Tanah Sareal',
      websiteUrl: 'https://setwan.kotabogor.go.id',
      imagePath: 'lib/assets/images/setwan.jpg',
    ),
    _AgencyContact(
      name: 'Inspektorat Daerah',
      email: 'inspektorat@kotabogor.go.id',
      phone: '(0251) 8324021',
      address: 'Jl. Raya Pajajaran No.5, RT.02/RW.04, Baranangsiang',
      websiteUrl: 'https://inspektorat.kotabogor.go.id',
      imagePath: 'lib/assets/images/inspektorat.jpg',
    ),
    _AgencyContact(
      name: 'Dinas Sosial',
      email: 'dinsos@kotabogor.go.id',
      phone: '(0251) 8324021',
      address: 'Jl. Merdeka No.142, RT.03/RW.05, Ciwaringin',
      websiteUrl: 'https://dinsos.kotabogor.go.id',
      imagePath: 'lib/assets/images/dinsos.jpg',
    ),
    _AgencyContact(
      name: 'Dinas Pemberdayaan Perempuan dan Perlindungan Anak',
      email: 'dppa@kotabogor.go.id',
      phone: '(0251) 8324021',
      address: 'Jl. Ciwaringin No.99, RT.01/RW.09, Ciwaringin,',
      websiteUrl: 'https://dppa.kotabogor.go.id',
      imagePath: 'lib/assets/images/dppa.jpg',
    ),
    _AgencyContact(
      name: 'Dinas Kesehatan',
      email: 'dinkes@kotabogor.go.id',
      phone: '(0251) 8331753',
      address:
          'Jalan R.M. Tirto Adhi Soerjo No.3, RT.02/RW.02, '
          'Tanah Sareal, Kota Bogor, Jawa Barat 16161',
      websiteUrl: 'https://dinkes.kotabogor.go.id',
      imagePath: 'lib/assets/images/dinkes.jpg',
    ),
    _AgencyContact(
      name: 'Dinas Pendidikan',
      email: 'disdik@kotabogor.go.id',
      phone: '(0251) 8321075',
      address:
          'Jalan Pangeran Sogiri No.7, Tanah Baru, Bogor Utara, '
          'Kota Bogor, Jawa Barat 16154',
      websiteUrl: 'https://disdik.kotabogor.go.id',
      imagePath: 'lib/assets/images/disdik.jpg',
    ),
    _AgencyContact(
      name: 'Dinas Perhubungan',
      email: 'dishub@kotabogor.go.id',
      phone: '(0251) 8324021',
      address:
          'Jalan Raya Tajur No.5, Bogor Timur, Kota Bogor, '
          'Jawa Barat 16144',
      websiteUrl: 'https://dishub.kotabogor.go.id',
      imagePath: 'lib/assets/images/dishub.jpg',
    ),
    _AgencyContact(
      name: 'Dinas Lingkungan Hidup',
      email: 'dlh@kotabogor.go.id',
      phone: '(0251) 8324021',
      address:
          'Jalan Raya Tajur No.5, Bogor Timur, Kota Bogor, '
          'Jawa Barat 16144',
      websiteUrl: 'https://dlh.kotabogor.go.id',
      imagePath: 'lib/assets/images/dlh.jpg',
    ),
    _AgencyContact(
      name: 'Dinas Lingkungan Hidup',
      email: 'dlh@kotabogor.go.id',
      phone: '(0251) 8324021',
      address:
          'Jalan Raya Tajur No.5, Bogor Timur, Kota Bogor, '
          'Jawa Barat 16144',
      websiteUrl: 'https://dlh.kotabogor.go.id',
      imagePath: 'lib/assets/images/dlh.jpg',
    ),
  ];

  Future<void> _openWebsite(BuildContext context, String url) async {
    final launched = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Tidak bisa membuka $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _OfficialsRow(officials: _officials),
            const SizedBox(height: 20),
            for (final agency in _agencies) ...[
              _AgencyCard(
                agency: agency,
                onWebsiteTap: () => _openWebsite(context, agency.websiteUrl),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}

/// Foto Walikota di kiri, foto Wakil Walikota di kanan, masing-masing
/// pakai `imagePath`-nya sendiri, dengan nama & jabatan di sisi dalamnya.
class _OfficialsRow extends StatelessWidget {
  const _OfficialsRow({required this.officials});

  final List<_Official> officials;

  @override
  Widget build(BuildContext context) {
    final walikota = officials[0];
    final wakil = officials[1];

    return Row(
      children: [
        _OfficialAvatar(imagePath: walikota.imagePath),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                walikota.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                walikota.title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xB30D1C2E),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                wakil.name.toUpperCase(),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                wakil.title.toUpperCase(),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xB30D1C2E),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        _OfficialAvatar(imagePath: wakil.imagePath),
      ],
    );
  }
}

class _OfficialAvatar extends StatelessWidget {
  const _OfficialAvatar({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        // Kalau asset belum ada / path salah, tampilkan placeholder
        // abu-abu daripada bikin app crash.
        errorBuilder: (context, error, stackTrace) => Container(
          width: 80,
          height: 80,
          color: const Color(0xFFE2E8F0),
          child: const Icon(Icons.person, color: Color(0xFF9AA5AD)),
        ),
      ),
    );
  }
}

/// Kartu satu dinas: avatar bulat (pakai `agency.imagePath`), nama, email,
/// telepon, dan kartu alamat kecil di bawahnya dengan link "Kunjungi Website".
class _AgencyCard extends StatelessWidget {
  const _AgencyCard({required this.agency, required this.onWebsiteTap});

  final _AgencyContact agency;
  final VoidCallback onWebsiteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.asset(
                  agency.imagePath,
                  width: 69,
                  height: 69,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 69,
                    height: 69,
                    color: const Color(0xFFE2E8F0),
                    child: const Icon(
                      Icons.apartment,
                      color: Color(0xFF9AA5AD),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agency.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      agency.email,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xB30D1C2E),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      agency.phone,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0x99000000),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black.withOpacity(0.05)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kota Bogor',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF142450),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  agency.address,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0x99000000),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: onWebsiteTap,
                    child: const Text(
                      'Kunjungi Website →',
                      style: TextStyle(
                        fontSize: 8,
                        color: Color(0xFF1A5F7A),
                        decoration: TextDecoration.underline,
                      ),
                    ),
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
