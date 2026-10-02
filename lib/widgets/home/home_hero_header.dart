import 'package:flutter/material.dart';

/// Header hero dengan gradient biru, logo BSW, dan sapaan ke user.
class HomeHeroHeader extends StatelessWidget {
  final String greeting;
  final String locationName;

  const HomeHeroHeader({
    super.key,
    required this.greeting,
    required this.locationName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 64),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F3E7A), Color(0xFF005F9E)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Dekorasi lingkaran blur, meniru elemen dekoratif di HTML
          Positioned(
            top: -40,
            right: -20,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -60,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
                    ),
                    child: const Icon(Icons.apartment, color: Color(0xFF00475E)),
                  ),
                  const SizedBox(width: 12),
                  const Flexible(
                    child: Text(
                      'Bogor Single Window',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                greeting,
                style: TextStyle(color: Colors.blue.shade100.withOpacity(0.9), fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                locationName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
