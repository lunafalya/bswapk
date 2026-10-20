import 'package:flutter/material.dart';

class EmergencyContact {
  const EmergencyContact({
    required this.label,
    required this.number,
    required this.icon,
  });

  final String label;
  final String number;
  final IconData icon;
}

const defaultEmergencyContacts = <EmergencyContact>[
  EmergencyContact(
    label: 'Layanan Darurat',
    number: '112',
    icon: Icons.phone_in_talk,
  ),
];
