import 'package:flutter/material.dart';

import '../widgets/language_toggle.dart';

/// Menyimpan bahasa aktif aplikasi (EN/ID) secara global.
class LanguageController extends ChangeNotifier {
  AppLanguage _language;

  LanguageController({AppLanguage initial = AppLanguage.en})
    : _language = initial;

  AppLanguage get language => _language;

  void setLanguage(AppLanguage language) {
    if (_language == language) return;
    _language = language;
    notifyListeners();
  }

  void toggle() {
    setLanguage(_language == AppLanguage.en ? AppLanguage.id : AppLanguage.en);
  }
}

/// InheritedNotifier supaya LanguageController bisa diakses dari widget mana pun
/// di bawah AppLanguageScope tanpa perlu package tambahan (mis. provider).
class AppLanguageScope extends InheritedNotifier<LanguageController> {
  const AppLanguageScope({
    super.key,
    required LanguageController controller,
    required super.child,
  }) : super(notifier: controller);

  static LanguageController of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AppLanguageScope>();
    assert(
      scope != null,
      'AppLanguageScope not found in widget tree. '
      'Wrap your app with AppLanguageScope in main.dart.',
    );
    return scope!.notifier!;
  }
}
