import 'package:flutter/material.dart';

class BswBottomNavItemData {
  final String label;
  final IconData icon;

  const BswBottomNavItemData({required this.label, required this.icon});
}

/// Bottom navigation bar dengan tombol Home yang "menonjol" ke atas,
/// meniru tampilan floating active icon pada desain HTML.
class BswBottomNavBar extends StatelessWidget {
  static const Color activeColor = Color(0xFF1E447B);

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<BswBottomNavItemData> _items = [
    BswBottomNavItemData(label: 'Home', icon: Icons.home_rounded),
    BswBottomNavItemData(label: 'Activity', icon: Icons.assignment_outlined),
    BswBottomNavItemData(label: 'Services', icon: Icons.more_outlined),
    BswBottomNavItemData(label: 'Alerts', icon: Icons.notifications_outlined),
    BswBottomNavItemData(label: 'Profile', icon: Icons.person_outline),
  ];

  const BswBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 64,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_items.length, (index) {
                final item = _items[index];
                final isActive = index == currentIndex;
                return _NavItem(
                  data: item,
                  isActive: isActive,
                  onTap: () => onTap(index),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final BswBottomNavItemData data;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.data,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              if (isActive)
                Positioned(
                  top: -22,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: BswBottomNavBar.activeColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 6),
                      ],
                    ),
                    child: Icon(data.icon, color: Colors.white, size: 26),
                  ),
                )
              else
                Positioned(
                  top: 8,
                  child: Icon(
                    data.icon,
                    size: 24,
                    color: const Color(0xFF40484D),
                  ),
                ),
              Positioned(
                bottom: 8,
                child: Text(
                  data.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive
                        ? BswBottomNavBar.activeColor
                        : const Color(0xFF40484D),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
