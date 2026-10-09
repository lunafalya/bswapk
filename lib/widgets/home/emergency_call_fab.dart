import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/emergency_contact.dart';
import '../../theme/app_colors.dart';

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
      onPressed: () => showEmergencySheet(context),
      child: const Icon(
        Icons.phone_in_talk_rounded,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  void showEmergencySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // lets the sheet grow beyond 9/16 of the screen
      useSafeArea: true, // stays below the status bar / notch
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(
                  'Panggilan Darurat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
              // Flexible + shrinkWrap: only as tall as needed, scrolls if not.
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 12),
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.error.withOpacity(0.1),
                        child: Icon(contact.icon, color: AppColors.error),
                      ),
                      title: Text(contact.label),
                      subtitle: Text(contact.number),
                      trailing: const Icon(Icons.call, color: AppColors.error),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        _call(context, contact.number);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _call(BuildContext context, String number) async {
    // keep digits and a leading + only
    final clean = number.replaceAll(RegExp(r'[^0-9+]'), '');
    final ok = await launchUrl(Uri(scheme: 'tel', path: clean));
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka aplikasi telepon')),
      );
    }
  }
}
