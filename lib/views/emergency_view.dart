import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/bsw_bottom_nav_bar.dart';
import 'home_view.dart';
import 'cctv_view.dart';
import 'wifi_view.dart';
import 'health_view.dart';
import 'news_view.dart';
import 'report_view.dart';
import 'profile_view.dart';

class EmergencyView extends StatelessWidget {
  const EmergencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency')),
      body: Center(child: Text('Emergency Content')),
    );
  }
}
