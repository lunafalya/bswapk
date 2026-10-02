import 'package:flutter/material.dart';

/// Model untuk satu kartu komunitas di halaman "Komunitas".
class CommunityGroup {
  final String name;
  final String description;
  final String location;
  final int memberCount;
  final String? avatarAsset;
  final Color joinButtonColor;
  final bool isJoined;

  const CommunityGroup({
    required this.name,
    required this.description,
    required this.location,
    required this.memberCount,
    this.avatarAsset,
    this.joinButtonColor = const Color(0xFF142450),
    this.isJoined = false,
  });

  CommunityGroup copyWith({bool? isJoined}) {
    return CommunityGroup(
      name: name,
      description: description,
      location: location,
      memberCount: memberCount,
      avatarAsset: avatarAsset,
      joinButtonColor: joinButtonColor,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}
