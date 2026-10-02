import 'package:flutter/material.dart';

import '../../models/ppdb_models.dart';

/// Timeline vertikal tahapan "Pendaftaran Murid Baru": tiap step diberi
/// panah penghubung ke step berikutnya, step aktif ditandai warna hijau.
class PpdbStepTimeline extends StatelessWidget {
  final String title;
  final String remainingLabel;
  final List<PpdbStep> steps;

  const PpdbStepTimeline({
    super.key,
    required this.title,
    required this.remainingLabel,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(11, 10, 11, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(104, 97, 97, 97).withOpacity(0.05),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 255, 255, 255),
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
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF142450),
                  ),
                ),
              ),
              Text(
                remainingLabel,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < steps.length; i++) ...[
            _StepRow(step: steps[i]),
            if (i != steps.length - 1) _StepArrow(),
          ],
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final PpdbStep step;

  const _StepRow({required this.step});

  @override
  Widget build(BuildContext context) {
    return Text(
      step.label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: step.isActive
            ? const Color(0xFF2E7D32)
            : Colors.black.withOpacity(0.6),
      ),
    );
  }
}

class _StepArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Icon(
        Icons.arrow_downward,
        size: 14,
        color: Colors.black.withOpacity(0.35),
      ),
    );
  }
}
