import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum AppLanguage { en, id }

/// Toggle switch "English | EN / ID" yang bisa dipakai di Login, Register,
/// dan Reset Password. Tap salah satu label EN/ID untuk berpindah bahasa.
class LanguageToggle extends StatelessWidget {
  final AppLanguage language;
  final ValueChanged<AppLanguage> onChanged;

  const LanguageToggle({
    super.key,
    required this.language,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          language == AppLanguage.en ? 'English' : 'Indonesia',
          style: const TextStyle(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              _LangOption(
                label: 'EN',
                isActive: language == AppLanguage.en,
                onTap: () => onChanged(AppLanguage.en),
              ),
              _LangOption(
                label: 'ID',
                isActive: language == AppLanguage.id,
                onTap: () => onChanged(AppLanguage.id),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LangOption extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _LangOption({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? AppColors.brandPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.onSurfaceVariant,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
