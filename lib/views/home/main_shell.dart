import 'package:flutter/material.dart';

import '../../widgets/bsw_bottom_nav_bar.dart';
import '../../widgets/home/emergency_call_fab.dart';
import 'home_view.dart';
import '../report/report_view.dart';
import '../news/news_view.dart';
import '../profile/profile_view.dart';

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
    if (index == 2) {
      const EmergencyCallFab().showEmergencySheet(context);
    } else {
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
        currentIndex: _currentIndex >= 2 ? _currentIndex + 1 : _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
