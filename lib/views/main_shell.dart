import 'package:flutter/material.dart';

import '../widgets/bsw_bottom_nav_bar.dart';
import 'home_view.dart';
import 'report_view.dart';
import 'news_view.dart';
import 'profile_view.dart';
import 'emergency_view.dart';

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
    EmergencyView(),
    NewsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BswBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
