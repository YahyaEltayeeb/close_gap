import 'package:flutter/material.dart';

class ExamQuestionNavigator extends StatelessWidget {
  final int total;
  final int current;
  final Map<int, int> answers;
  final List questions;
  final void Function(int) onTap;

  const ExamQuestionNavigator({
    super.key,
    required this.total,
    required this.current,
    required this.answers,
    required this.questions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Question Navigator',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF111827))),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(total, (i) {
              final q = questions[i];
              final isAnswered = answers.containsKey(q.id);
              final isCurrent = i == current;

              Color bgColor;
              Color textColor;
              Border border;

              if (isCurrent) {
                bgColor = const Color(0xFF2563EB);
                textColor = Colors.white;
                border = Border.all(color: const Color(0xFF2563EB));
              } else if (isAnswered) {
                bgColor = const Color(0xFFEFF6FF);
                textColor = const Color(0xFF2563EB);
                border = Border.all(color: const Color(0xFFBFDBFE));
              } else {
                bgColor = const Color(0xFFF3F4F6);
                textColor = const Color(0xFF6B7280);
                border = Border.all(color: const Color(0xFFE5E7EB));
              }

              return GestureDetector(
                onTap: () => onTap(i),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: border,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: textColor),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}