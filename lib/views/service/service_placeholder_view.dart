import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class _PlaceholderServiceScaffold extends StatelessWidget {
  const _PlaceholderServiceScaffold({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(title, style: const TextStyle(color: AppColors.onSurface)),
        iconTheme: const IconThemeData(color: AppColors.onSurface),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppColors.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              '$title — konten belum tersedia',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BpjsView extends StatelessWidget {
  const BpjsView({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderServiceScaffold(
    title: 'BPJS',
    icon: Icons.medical_services,
  );
}

class PpdbView extends StatelessWidget {
  const PpdbView({super.key});
  @override
  Widget build(BuildContext context) =>
      const _PlaceholderServiceScaffold(title: 'PPDB', icon: Icons.school);
}

class KomunitasView extends StatelessWidget {
  const KomunitasView({super.key});
  @override
  Widget build(BuildContext context) =>
      const _PlaceholderServiceScaffold(title: 'Komunitas', icon: Icons.groups);
}

class PerizinanView extends StatelessWidget {
  const PerizinanView({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderServiceScaffold(
    title: 'Perizinan',
    icon: Icons.description,
  );
}

class BansosView extends StatelessWidget {
  const BansosView({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderServiceScaffold(
    title: 'Bansos',
    icon: Icons.volunteer_activism,
  );
}

class RuteView extends StatelessWidget {
  const RuteView({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderServiceScaffold(
    title: 'Rute',
    icon: Icons.directions_bus,
  );
}

class BerkasView extends StatelessWidget {
  const BerkasView({super.key});
  @override
  Widget build(BuildContext context) =>
      const _PlaceholderServiceScaffold(title: 'Berkas', icon: Icons.folder);
}

class PerangkatDaerahView extends StatelessWidget {
  const PerangkatDaerahView({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderServiceScaffold(
    title: 'Perangkat Daerah',
    icon: Icons.account_balance,
  );
}

class TagihanView extends StatelessWidget {
  const TagihanView({super.key});
  @override
  Widget build(BuildContext context) =>
      const _PlaceholderServiceScaffold(title: 'Tagihan', icon: Icons.payments);
}

class PbbView extends StatelessWidget {
  const PbbView({super.key});
  @override
  Widget build(BuildContext context) =>
      const _PlaceholderServiceScaffold(title: 'PBB', icon: Icons.home_work);
}

class AsetView extends StatelessWidget {
  const AsetView({super.key});
  @override
  Widget build(BuildContext context) =>
      const _PlaceholderServiceScaffold(title: 'Aset', icon: Icons.apartment);
}
