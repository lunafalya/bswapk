import 'package:flutter/material.dart';

class LevelFilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const LevelFilterChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 33,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFFBA1A1A)
                : Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black.withOpacity(0.1)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : const Color(0xFF142450),
            ),
          ),
        ),
      ),
    );
  }
}
