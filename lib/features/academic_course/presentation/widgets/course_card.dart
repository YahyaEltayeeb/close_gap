import 'package:flutter/material.dart';
import 'package:close_gap/features/academic_course/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/publish_exam_academic_entity.dart';
import 'course_action_button.dart';

class CourseCard extends StatelessWidget {
  final AcademicCourseEntity course;
  final List<PublishExamAcademicEntity> publishedExams;
  final VoidCallback onExplanationTap;
  final VoidCallback onPublishedExamTap;

  const CourseCard({
    super.key,
    required this.course,
    required this.publishedExams,
    required this.onExplanationTap,
    required this.onPublishedExamTap,
  });

  PublishExamAcademicEntity? get _courseExam {
    try {
      return publishedExams.firstWhere(
        (e) => e.academicCourseId == course.id,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final exam = _courseExam;
    final hasExam = exam != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Image Placeholder
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 90,
              width: double.infinity,
              color: const Color(0xFFE3F2FD),
              child: const Icon(
                Icons.school,
                size: 36,
                color: Color(0xFF90CAF9),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    course.name ?? 'Unknown Course',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  CourseActionButton(
                    label: 'Explanation in Arabic',
                    onTap: onExplanationTap,
                  ),
                  CourseActionButton(
                    label: 'Practical Project',
                    onTap: null,
                    isDisabled: true,
                  ),
                  CourseActionButton(
                    label: 'See material',
                    onTap: null,
                    isDisabled: true,
                  ),
                  CourseActionButton(
                    label: hasExam ? 'Published Exam Now' : 'No Published Exam Yet',
                    onTap: hasExam ? onPublishedExamTap : null,
                    isDisabled: !hasExam,
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