class TaxBillResult {
  final String categoryLabel;
  final String statusLabel;
  final String ownerName;
  final String idNumber;
  final String objectTypeLabel;
  final String amountLabel;
  final String addressLabel;
  final String extraInfoLabel;
  final String payButtonLabel;
  final String? avatarAsset;

  const TaxBillResult({
    required this.categoryLabel,
    required this.statusLabel,
    required this.ownerName,
    required this.idNumber,
    required this.objectTypeLabel,
    required this.amountLabel,
    required this.addressLabel,
    required this.extraInfoLabel,
    required this.payButtonLabel,
    this.avatarAsset,
  });
}
