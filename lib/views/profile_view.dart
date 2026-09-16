import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/bsw_bottom_nav_bar.dart';
import 'main_shell.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(child: Text('Profile Content')),
    );
  }
}
