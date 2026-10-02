import 'package:flutter/material.dart';

import '../../models/tax_bill.dart';
import '../../assets/images/dummy_asset_image.dart';
import 'tax_check_field.dart';

class TaxBillResultCard extends StatelessWidget {
  final TaxBillResult result;
  final VoidCallback? onPay;

  const TaxBillResultCard({super.key, required this.result, this.onPay});

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
      padding: const EdgeInsets.all(19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildIdentityRow(),
          const SizedBox(height: 14),
          _buildObjectInfoBox(),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPay,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBA1A1A),
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
              child: Text(result.payButtonLabel),
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
            child: result.avatarAsset != null
                ? DummyAssetImage(
                    assetPath: result.avatarAsset!,
                    placeholderIcon: Icons.person,
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
                children: [
                  Expanded(
                    child: Text(
                      result.categoryLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                  Text(
                    result.statusLabel,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                result.ownerName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                result.idNumber,
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

  Widget _buildObjectInfoBox() {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4)),
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
                  result.objectTypeLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
              Text(
                result.extraInfoLabel,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            result.amountLabel,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            result.addressLabel,
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
