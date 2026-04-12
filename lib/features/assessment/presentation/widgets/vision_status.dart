import 'package:close_gap/features/exam_monitoring/presentation/manager/vision_check_cubit.dart';
import 'package:flutter/material.dart';

class ExamVisionStatus extends StatelessWidget {
  final VisionCheckState visionState;

  const ExamVisionStatus({super.key, required this.visionState});

  @override
  Widget build(BuildContext context) {
    if (visionState is VisionCheckWarning) {
      final strikes = (visionState as VisionCheckWarning).strikes;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cheating banner
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFCA5A5)),
            ),
            child: Row(
              children: const [
                Icon(Icons.warning_rounded,
                    color: Color(0xFFEF4444), size: 20),
                SizedBox(width: 10),
                Text(
                  'Cheating detected',
                  style: TextStyle(
                      color: Color(0xFFDC2626),
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Flags + strikes
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Flags detected',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFF111827))),
                      const SizedBox(height: 6),
                      Text(
                        _getReasonText(strikes),
                        style: const TextStyle(
                            color: Color(0xFFDC2626),
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Strike: 3/$strikes',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF374151)),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Safe state
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child:
                    const Icon(Icons.check, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              const Text(
                'Everything looks good',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'You have 3 strikes, after\nwhich the exam will be\ncancelled.',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    height: 1.5),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Strike: 3/0',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xFF374151)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getReasonText(int strikes) {
    switch (strikes) {
      case 1:
        return 'Looking away from screen.';
      case 2:
        return 'Suspicious movement detected.';
      default:
        return 'Holding a mobile phone during exam.';
    }
  }
}