import 'package:flutter/material.dart';

import '../models/emergency_contact.dart';
import '../theme/app_colors.dart';

/// FAB darurat (mengambang di atas BswBottomNavBar) yang membuka bottom
/// sheet berisi daftar kontak panggilan darurat.
///
/// TODO: ganti aksi `onTap` tiap [EmergencyContact] agar benar-benar
/// melakukan panggilan, mis. lewat package `url_launcher`:
///   launchUrl(Uri.parse('tel:${contact.number}'));
class EmergencyCallFab extends StatelessWidget {
  const EmergencyCallFab({super.key, this.contacts = defaultEmergencyContacts});

  final List<EmergencyContact> contacts;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'emergencyCallFab',
      backgroundColor: AppColors.error,
      elevation: 4,
      shape: const CircleBorder(),
      onPressed: () => _showEmergencySheet(context),
      child: const Icon(Icons.phone_in_talk_rounded, color: Colors.white, size: 28),
    );
  }

  void _showEmergencySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Panggilan Darurat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
                for (final contact in contacts)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.error.withOpacity(0.1),
                      child: Icon(contact.icon, color: AppColors.error),
                    ),
                    title: Text(contact.label),
                    subtitle: Text(contact.number),
                    trailing: const Icon(Icons.call, color: AppColors.error),
                    onTap: () {
                      // TODO: launchUrl(Uri.parse('tel:${contact.number}'));
                      Navigator.of(sheetContext).pop();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
