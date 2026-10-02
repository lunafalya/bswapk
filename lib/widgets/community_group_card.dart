import 'package:flutter/material.dart';

import '../models/community_group.dart';
import '../assets/images/dummy_asset_image.dart';

/// Kartu komunitas: avatar bulat, nama, deskripsi, jumlah anggota, lokasi,
/// dan tombol "Gabung" full-width — sesuai desain Figma "Komunitas".
class CommunityGroupCard extends StatelessWidget {
  final CommunityGroup group;
  final VoidCallback? onJoin;

  const CommunityGroupCard({super.key, required this.group, this.onJoin});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(19, 19, 19, 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar komunitas (placeholder, isi dari lib/assets saat tersedia).
              ClipOval(
                child: SizedBox(
                  width: 69,
                  height: 69,
                  child: group.avatarAsset != null
                      ? DummyAssetImage(
                          assetPath: group.avatarAsset!,
                          placeholderIcon: Icons.groups,
                        )
                      : Container(color: const Color(0xFFD9D9D9)),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${group.memberCount} Anggota',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: group.joinButtonColor,
                            ),
                          ),
                        ),
                        Text(
                          group.location,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      group.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      group.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onJoin,
              style: ElevatedButton.styleFrom(
                backgroundColor: group.isJoined
                    ? Colors.grey.shade400
                    : group.joinButtonColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.7,
                ),
              ),
              child: Text(group.isJoined ? 'Bergabung' : 'Gabung'),
            ),
          ),
        ],
      ),
    );
  }
}
