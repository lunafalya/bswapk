enum SchoolLevel { sd, smp, sma }

extension SchoolLevelLabel on SchoolLevel {
  String get label {
    switch (this) {
      case SchoolLevel.sd:
        return 'SD';
      case SchoolLevel.smp:
        return 'SMP';
      case SchoolLevel.sma:
        return 'SMA';
    }
  }
}

/// Satu tahapan pada timeline "Pendaftaran Murid Baru".
class PpdbStep {
  final String label;
  final bool isActive;

  const PpdbStep({required this.label, this.isActive = false});
}

class SchoolRegistration {
  final SchoolLevel level;
  final String name;
  final String code;
  final String location;
  final String headmasterName;
  final String address;
  final String infoPeriodLabel;
  final String timelineRemainingLabel;
  final List<PpdbStep> steps;
  final String? avatarAsset;

  const SchoolRegistration({
    required this.level,
    required this.name,
    required this.code,
    required this.location,
    required this.headmasterName,
    required this.address,
    required this.infoPeriodLabel,
    required this.timelineRemainingLabel,
    required this.steps,
    this.avatarAsset,
  });
}
