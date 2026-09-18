import 'package:flutter/material.dart';

import '../widgets/bsw_bottom_nav_bar.dart';
import '../widgets/emergency_call_fab.dart';
import 'home_view.dart';
import 'report_view.dart';
import 'news_view.dart';
import 'profile_view.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeView(),
    ReportView(),
    NewsView(),
    ProfileView(),
  ];

  void _onTabTapped(int index) {
    // Indeks 2 adalah posisi tombol "Darurat" di BswBottomNavBar
    if (index == 2) {
      // Panggil fungsi modal bottom sheet nomor darurat langsung dari widget EmergencyCallFab
      const EmergencyCallFab().showEmergencySheet(context);
    } else {
      // Jika menekan tab selain Darurat, sesuaikan indeks halaman
      // (karena EmergencyView dihapus dari _pages, indeks setelah angka 2 dikurangi 1)
      setState(() {
        _currentIndex = index > 2 ? index - 1 : index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BswBottomNavBar(
        // Sesuaikan visual pilihan aktif pada BswBottomNavBar
        currentIndex: _currentIndex >= 2 ? _currentIndex + 1 : _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
