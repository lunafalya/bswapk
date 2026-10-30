import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_colors.dart';
import 'perangkat_daerah_data.dart';

// Palette used on this screen.
const _navy = Color(0xFF142450);
const _teal = Color(0xFF1A5F7A);
const _ink = Color(0xFF0D1C2E);
const _muted = Color(0xFF64748B);
const _border = Color(0xFFE2E8F0);
const _tealSoft = Color(0x141A5F7A); // teal @ 8%

const _fallbackLogo = 'lib/assets/images/pd/bogor.png';

class PerangkatDaerahView extends StatefulWidget {
  const PerangkatDaerahView({super.key});

  @override
  State<PerangkatDaerahView> createState() => _PerangkatDaerahViewState();
}

class _PerangkatDaerahViewState extends State<PerangkatDaerahView> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AgencyContact> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return agencies;
    return agencies.where((a) => a.name.toLowerCase().contains(q)).toList();
  }

  void _onQueryChanged(String value) => setState(() => _query = value);

  void _clearQuery() {
    _searchController.clear();
    setState(() => _query = '');
  }

  Future<void> _open(Uri uri) async {
    var launched = false;
    try {
      launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
    if (!launched && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Tidak bisa membuka $uri')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Perangkat Daerah',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
          ),
        ),
      ),
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            sliver: SliverToBoxAdapter(
              child: _LeadersCard(officials: officials),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            sliver: SliverToBoxAdapter(
              child: _SearchField(
                controller: _searchController,
                showClear: _query.isNotEmpty,
                onChanged: _onQueryChanged,
                onClear: _clearQuery,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            sliver: SliverToBoxAdapter(
              child: _ListHeading(count: items.length),
            ),
          ),
          if (items.isEmpty)
            const SliverToBoxAdapter(child: _EmptyState())
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _AgencyCard(agency: items[index], onOpen: _open),
                  ),
                  childCount: items.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pimpinan (Walikota & Wakil Walikota)
// ---------------------------------------------------------------------------

class _LeadersCard extends StatelessWidget {
  const _LeadersCard({required this.officials});

  final List<Official> officials;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_navy, _teal],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40142450),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'PIMPINAN KOTA BOGOR',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final official in officials)
                Expanded(child: _Leader(official: official)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Leader extends StatelessWidget {
  const _Leader({required this.official});

  final Official official;

  static const _size = 76.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              official.imagePath,
              width: _size,
              height: _size,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: _size,
                height: _size,
                color: _border,
                child: const Icon(Icons.person, size: 36, color: _muted),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          official.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          official.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Search + heading + empty state
// ---------------------------------------------------------------------------

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.showClear,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final bool showClear;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color),
    );

    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      style: const TextStyle(fontSize: 14, color: _ink),
      decoration: InputDecoration(
        hintText: 'Cari perangkat daerah...',
        hintStyle: const TextStyle(fontSize: 14, color: _muted),
        prefixIcon: const Icon(Icons.search, color: _teal),
        suffixIcon: showClear
            ? IconButton(
                icon: const Icon(Icons.close, size: 20, color: _muted),
                onPressed: onClear,
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: border(_border),
        enabledBorder: border(_border),
        focusedBorder: border(_teal),
      ),
    );
  }
}

class _ListHeading extends StatelessWidget {
  const _ListHeading({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Daftar Perangkat Daerah',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _tealSoft,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '$count',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _teal,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 40, color: _muted),
          SizedBox(height: 12),
          Text(
            'Perangkat daerah tidak ditemukan',
            style: TextStyle(fontSize: 14, color: _muted),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Kartu perangkat daerah
// ---------------------------------------------------------------------------

class _AgencyCard extends StatelessWidget {
  const _AgencyCard({required this.agency, required this.onOpen});

  final AgencyContact agency;
  final ValueChanged<Uri> onOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0D1C2E),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _AgencyLogo(imagePath: agency.imagePath),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  agency.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: _border),
          const SizedBox(height: 10),
          for (final email in agency.emails)
            _ContactRow(
              icon: Icons.mail_outline,
              text: email,
              onTap: () => onOpen(Uri(scheme: 'mailto', path: email)),
            ),
          _ContactRow(
            icon: Icons.phone_outlined,
            text: agency.phone,
            onTap: () => onOpen(Uri(scheme: 'tel', path: agency.phoneDialable)),
          ),
          _ContactRow(icon: Icons.location_on_outlined, text: agency.address),
          if (agency.hasWebsite) ...[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: _WebsiteButton(
                onPressed: () => onOpen(Uri.parse(agency.websiteUrl.trim())),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AgencyLogo extends StatelessWidget {
  const _AgencyLogo({required this.imagePath});

  final String imagePath;

  static const _size = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            _fallbackLogo,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.account_balance, color: _muted),
          ),
        ),
      ),
    );
  }
}

/// One line of contact info with a leading icon. Tappable rows are shown in
/// the accent color; plain rows (address) are muted.
class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text, this.onTap});

  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tappable = onTap != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: _teal),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: tappable ? FontWeight.w600 : FontWeight.w400,
                  color: tappable ? _teal : _muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WebsiteButton extends StatelessWidget {
  const _WebsiteButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.open_in_new, size: 16),
      label: const Text('Kunjungi Website'),
      style: TextButton.styleFrom(
        foregroundColor: _teal,
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
      ),
    );
  }
}
