import 'package:flutter/material.dart';

import '../../models/ppdb_models.dart';
import '../../assets/images/dummy_asset_image.dart';
import 'ppdb_step_timeline.dart';

class SchoolRegistrationCard extends StatelessWidget {
  final SchoolRegistration school;
  final VoidCallback? onRegister;

  const SchoolRegistrationCard({
    super.key,
    required this.school,
    this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(66, 255, 255, 255),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildIdentityRow(),
          const SizedBox(height: 14),
          _buildHeadmasterInfo(),
          const SizedBox(height: 10),
          PpdbStepTimeline(
            title: 'Pendaftaran Murid Baru',
            remainingLabel: school.timelineRemainingLabel,
            steps: school.steps,
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF142450),
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
              child: const Text('Daftar Sekarang'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: SizedBox(
            width: 69,
            height: 69,
            child: school.avatarAsset != null
                ? DummyAssetImage(
                    assetPath: school.avatarAsset!,
                    placeholderIcon: Icons.school,
                  )
                : Container(color: const Color(0xFFD9D9D9)),
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                school.location,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF142450),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                school.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                school.code,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeadmasterInfo() {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 43, 42, 42).withOpacity(0.05),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(66, 255, 255, 255),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Kota Bogor',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF142450),
                  ),
                ),
              ),
              Text(
                school.infoPeriodLabel,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            school.headmasterName,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            school.address,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black.withOpacity(0.6),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
