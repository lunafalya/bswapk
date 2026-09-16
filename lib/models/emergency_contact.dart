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
  EmergencyContact(label: 'Polisi', number: '110', icon: Icons.local_police),
  EmergencyContact(
    label: 'Pemadam Kebakaran',
    number: '113',
    icon: Icons.local_fire_department,
  ),
  EmergencyContact(
    label: 'Ambulans',
    number: '119',
    icon: Icons.medical_services,
  ),
  EmergencyContact(label: 'Basarnas', number: '115', icon: Icons.support_agent),
  EmergencyContact(
    label: 'Layanan Darurat Lainnya',
    number: '112',
    icon: Icons.phone_in_talk,
  ),
  EmergencyContact(
    label: 'PLN',
    number: '123',
    icon: Icons.electrical_services,
  ),
  EmergencyContact(label: 'JASAMARGA', number: '14080', icon: Icons.car_rental),
];
