import 'package:close_gap/features/academic_course/domain/entities/publish_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/presentation/pages/exam_intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/features/academic_course/presentation/manager/academic_course_cubit.dart';
import 'package:close_gap/features/academic_course/presentation/manager/academic_course_states.dart';

class PublishedExamsScreen extends StatefulWidget {
  const PublishedExamsScreen({super.key});

  @override
  State<PublishedExamsScreen> createState() => _PublishedExamsScreenState();
}

class _PublishedExamsScreenState extends State<PublishedExamsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AcademicCourseCubit>().getAcademicCoursePublishedExams();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF1A1A2E)),
        title: const Text(
          'Published Exams',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AcademicCourseCubit, AcademicCourseStates>(
        buildWhen: (prev, curr) =>
            curr is AcademicCoursePublishedExamsLoading ||
            curr is AcademicCoursePublishedExamsSuccess ||
            curr is AcademicCoursePublishedExamsFailure,
        builder: (context, state) {
          if (state is AcademicCoursePublishedExamsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2196F3)),
            );
          }

          if (state is AcademicCoursePublishedExamsFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(state.message,
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context
                        .read<AcademicCourseCubit>()
                        .getAcademicCoursePublishedExams(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is AcademicCoursePublishedExamsSuccess) {
            final exams = state.exams;
            if (exams.isEmpty) {
              return const Center(child: Text('No published exams found.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: exams.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final exam = exams[index];
                return _ExamCard(
                  exam: exam,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AcademicCourseCubit>(),
                          child: ExamIntroScreen(exam: exam),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  final PublishExamAcademicEntity exam;
  final VoidCallback onTap;

  const _ExamCard({required this.exam, required this.onTap});

  Color get _examTypeColor {
    switch (exam.examType?.toLowerCase()) {
      case 'final':
        return const Color(0xFFE53935);
      case 'quiz':
        return const Color(0xFF7B1FA2);
      case 'assignment':
        return const Color(0xFF1565C0);
      default:
        return const Color(0xFF2196F3);
    }
  }

  String get _statusText {
    switch (exam.myStatus?.toLowerCase()) {
      case 'submitted':
        return 'Submitted';
      case 'not_started':
        return 'Not Started';
      case 'in_progress':
        return 'In Progress';
      default:
        return exam.myStatus ?? '';
    }
  }

  Color get _statusColor {
    switch (exam.myStatus?.toLowerCase()) {
      case 'submitted':
        return const Color(0xFF2E7D32);
      case 'not_started':
        return const Color(0xFFF57C00);
      case 'in_progress':
        return const Color(0xFF1565C0);
      default:
        return const Color(0xFF757575);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Exam Type Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _examTypeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      exam.examType?.toUpperCase() ?? '',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _examTypeColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusText,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                exam.title ?? 'Untitled Exam',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                exam.academicCourseName ?? '',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF757575),
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Color(0xFFF0F0F0)),
              const SizedBox(height: 12),
              Row(
                children: [
                  _InfoChip(
                    icon: Icons.help_outline,
                    label: '${exam.questionCount ?? 0} Questions',
                  ),
                  const SizedBox(width: 12),
                  _InfoChip(
                    icon: Icons.timer_outlined,
                    label: '${exam.durationMinutes ?? 0} min',
                  ),
                  const SizedBox(width: 12),
                  _InfoChip(
                    icon: Icons.star_outline,
                    label: '${exam.totalMarks ?? 0} Marks',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF2196F3)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF757575),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}