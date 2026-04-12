import 'package:flutter/material.dart';

class ExamInstructionsCard extends StatelessWidget {
  const ExamInstructionsCard({super.key});

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Instructions',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF111827))),
          const SizedBox(height: 10),
          ...[
            'All activity is monitored.',
            'Please complete your exam without using notes, external devices, or other assistance.',
            'Keep your webcam, microphone, and screen sharing enabled for the full duration of the exam',
          ].map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ',
                      style:
                          TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
                  Expanded(
                    child: Text(t,
                        style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 13,
                            height: 1.4)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}