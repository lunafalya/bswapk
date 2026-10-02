import 'package:flutter/material.dart';

import '../../models/community_group.dart';
import '../../theme/app_colors.dart';
import '../../widgets/bsw_bottom_nav_bar.dart';
import '../../widgets/community_group_card.dart';

class KomunitasView extends StatefulWidget {
  const KomunitasView({super.key});

  @override
  State<KomunitasView> createState() => _KomunitasViewState();
}

class _KomunitasViewState extends State<KomunitasView> {
  final _searchController = TextEditingController();

  int _currentNavIndex = 1;

  late final List<CommunityGroup> _groups = [
    const CommunityGroup(
      name: 'Pelari Kalcer',
      description: 'Kumpulan Pelari Kalcer Kota Bogor',
      location: 'Bogor Tengah',
      memberCount: 83,
      joinButtonColor: Color(0xFF142450),
    ),
    const CommunityGroup(
      name: 'Pelari Kalcer',
      description: 'Kumpulan Pelari Kalcer Kota Bogor',
      location: 'Bogor Tengah',
      memberCount: 83,
      joinButtonColor: Color(0xFF142450),
    ),
    const CommunityGroup(
      name: 'Pelari Kalcer',
      description: 'Kumpulan Pelari Kalcer Kota Bogor',
      location: 'Bogor Tengah',
      memberCount: 83,
      joinButtonColor: Color(0xFF142450),
    ),
    const CommunityGroup(
      name: 'Pelari Kalcer',
      description: 'Kumpulan Pelari Kalcer Kota Bogor',
      location: 'Bogor Tengah',
      memberCount: 83,
      joinButtonColor: Color(0xFF142450),
    ),
    const CommunityGroup(
      name: 'Pelari Kalcer',
      description: 'Kumpulan Pelari Kalcer Kota Bogor',
      location: 'Bogor Tengah',
      memberCount: 83,
      joinButtonColor: Color(0xFF142450),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CommunityGroup> _filterGroups(String query) {
    if (query.trim().isEmpty) return _groups;
    final lowerQuery = query.toLowerCase();
    return _groups
        .where(
          (g) =>
              g.name.toLowerCase().contains(lowerQuery) ||
              g.location.toLowerCase().contains(lowerQuery) ||
              g.description.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  void _handleJoin(int indexInFullList) {
    setState(() {
      _groups[indexInFullList] = _groups[indexInFullList].copyWith(
        isJoined: !_groups[indexInFullList].isJoined,
      );
    });
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
                    'Komunitas Kota Bogor',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Wadah berkumpulnya warga Bogor untuk saling berbagi informasi terkini, '
                    'seputar kuliner legendaris, event seru, hingga aspirasi pembangunan kota.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.onSurfaceVariant,
                      height: 20 / 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 13),
                  AnimatedBuilder(
                    animation: _searchController,
                    builder: (context, _) {
                      final filtered = _filterGroups(_searchController.text);
                      if (filtered.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Text(
                              'Komunitas tidak ditemukan.',
                              style: TextStyle(
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          for (final group in filtered) ...[
                            CommunityGroupCard(
                              group: group,
                              onJoin: () => _handleJoin(_groups.indexOf(group)),
                            ),
                            const SizedBox(height: 13),
                          ],
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BswBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) => setState(() => _currentNavIndex = index),
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

  Widget _buildSearchBar() {
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
