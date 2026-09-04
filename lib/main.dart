import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'theme/language_controller.dart';
import 'views/login_view.dart';

void main() {
  runApp(const BswApp());
}

class BswApp extends StatefulWidget {
  const BswApp({super.key});

  @override
  State<BswApp> createState() => _BswAppState();
}

class _BswAppState extends State<BswApp> {
  final _languageController = LanguageController();

  @override
  void dispose() {
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLanguageScope(
      controller: _languageController,
      child: MaterialApp(
        title: 'Bogor Single Window',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const LoginView(),
      ),
    );
  }
}
