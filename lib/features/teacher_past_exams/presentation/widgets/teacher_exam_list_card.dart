import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/components/custom_elevated_button.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_list_item_entity.dart';
import 'package:flutter/material.dart';

class TeacherExamListCard extends StatelessWidget {
  const TeacherExamListCard({
    super.key,
    required this.exam,
    required this.onViewResult,
  });

  final TeacherExamListItemEntity exam;
  final VoidCallback onViewResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  exam.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF202124),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: exam.isPublished
                      ? const Color(0xFFE8F7EE)
                      : const Color(0xFFFFF4E5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  exam.isPublished ? 'Published' : 'Draft',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: exam.isPublished
                        ? const Color(0xFF1E8E3E)
                        : const Color(0xFFB26A00),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            exam.academicCourseName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _ExamMetaChip(label: _labelizeExamType(exam.examType)),
              _ExamMetaChip(label: '${exam.durationMinutes} min'),
              _ExamMetaChip(label: '${exam.questionCount} questions'),
              _ExamMetaChip(
                label: '${exam.totalMarks.toStringAsFixed(0)} marks',
              ),
            ],
          ),
          const SizedBox(height: 18),
          CustomElevatedButton(
            onPressed: onViewResult,
            isLoading: false,
            widget: const Text(
              'View result',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            containerColor: AppColors.lightPrimary,
          ),
        ],
      ),
    );
  }

  String _labelizeExamType(String value) {
    switch (value.toLowerCase()) {
      case 'midterm':
        return 'Midterm';
      case 'final':
        return 'Final';
      case 'quiz':
        return 'Quiz';
      case 'assignment':
        return 'Assignment';
      default:
        return value;
    }
  }
}

class _ExamMetaChip extends StatelessWidget {
  const _ExamMetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF4B5563),
        ),
      ),
    );
  }
}
