import 'package:close_gap/features/assessment/presentation/manager/exam/exam_cubit.dart';
import 'package:flutter/material.dart';

class ExamQuestionCard extends StatelessWidget {
  final ExamLoaded examState;
  final void Function(int, int) onAnswer;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const ExamQuestionCard({
    super.key,
    required this.examState,
    required this.onAnswer,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final q = examState.questions[examState.currentIndex];
    final isLast = examState.currentIndex == examState.questions.length - 1;

    return Container(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              'Question ${examState.currentIndex + 1} of ${examState.questions.length}',
              style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(
              q.text ?? '',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                  height: 1.4),
            ),
          ),

          // Options
          ...(q.options ?? []).map((o) {
            final selected = examState.answers[q.id] == o.id;
            return GestureDetector(
              onTap: () {
                if (q.id != null && o.id != null) onAnswer(q.id!, o.id!);
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFEFF6FF)
                      : const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFF2563EB)
                        : const Color(0xFFE5E7EB),
                    width: selected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        o.text ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: selected
                              ? const Color(0xFF1D4ED8)
                              : const Color(0xFF374151),
                          fontWeight: selected
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected
                              ? const Color(0xFF2563EB)
                              : const Color(0xFFD1D5DB),
                          width: 2,
                        ),
                        color: selected
                            ? const Color(0xFF2563EB)
                            : Colors.transparent,
                      ),
                      child: selected
                          ? const Icon(Icons.check,
                              size: 12, color: Colors.white)
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }),

          // Nav buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                        examState.currentIndex > 0 ? onPrevious : null,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF6B7280),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Previous'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(isLast ? 'Finish' : 'Next',
                        style:
                            const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}