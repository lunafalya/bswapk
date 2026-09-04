import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;

  const HomeSearchBar({super.key, this.controller, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        style: const TextStyle(color: AppColors.onSurface, fontSize: 16),
        decoration: InputDecoration(
          hintText: 'Looking for Services?',
          hintStyle: TextStyle(color: AppColors.outline.withOpacity(0.7)),
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(999),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
