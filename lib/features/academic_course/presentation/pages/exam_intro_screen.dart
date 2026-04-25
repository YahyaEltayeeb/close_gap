import 'package:close_gap/features/academic_course/presentation/manager/academic_course_cubit.dart';
import 'package:close_gap/features/academic_course/presentation/manager/academic_course_states.dart';
import 'package:close_gap/features/academic_course/presentation/pages/academic_exam_screen.dart';
import 'package:close_gap/features/academic_course/presentation/widgets/exam_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/features/academic_course/domain/entities/publish_exam_academic_entity.dart';

class ExamIntroScreen extends StatelessWidget {
  final PublishExamAcademicEntity exam;

  const ExamIntroScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF1A1A2E)),
      ),
      body: BlocListener<AcademicCourseCubit, AcademicCourseStates>(
        listenWhen: (prev, curr) =>
            curr is StartAcademicExamSuccess ||
            curr is StartAcademicExamFailure,
        listener: (context, state) {
          if (state is StartAcademicExamSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<AcademicCourseCubit>(),
                  child: AcademicExamScreen(
                    examData: state.examData,
                    courseName:
                        exam.academicCourseName ?? exam.title ?? 'Exam',
                    examId: exam.id!,
                  ),
                ),
              ),
            );
          } else if (state is StartAcademicExamFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                exam.title ?? 'Exam',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                exam.description ??
                    'Hello, are you ready to take the exam and get the highest marks?',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ExamInfoCard(
                      icon: Icons.timer_outlined,
                      title: 'Estimated Time',
                      subtitle:
                          'Plan for about ${exam.durationMinutes ?? 0} minutes to complete the assessment',
                    ),
                    const Divider(height: 24, color: Color(0xFFF0F0F0)),
                    ExamInfoCard(
                      icon: Icons.help_outline,
                      title: 'Number of questions',
                      subtitle:
                          'There are ${exam.questionCount ?? 0} multiple-choice questions in total',
                    ),
                    const Divider(height: 24, color: Color(0xFFF0F0F0)),
                    ExamInfoCard(
                      icon: Icons.article_outlined,
                      title: 'Question format',
                      subtitle:
                          'All questions are in a ${exam.examType ?? 'multiple-choice'} format',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Instructions & Rules',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _InstructionItem(
                      text:
                          'Answer honestly based on your true preferences and abilities.',
                    ),
                    const _InstructionItem(
                      text:
                          'Please refrain from using any external resources or assistance.',
                    ),
                    const _InstructionItem(
                      text:
                          'Your results will be available after review by the course instructor.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              BlocBuilder<AcademicCourseCubit, AcademicCourseStates>(
                buildWhen: (prev, curr) =>
                    curr is StartAcademicExamLoading ||
                    curr is StartAcademicExamSuccess ||
                    curr is StartAcademicExamFailure,
                builder: (context, state) {
                  final isLoading = state is StartAcademicExamLoading;
                  return SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (exam.id != null) {
                                context
                                    .read<AcademicCourseCubit>()
                                    .startAcademicExam(exam.id!);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : const Text(
                              'Start Exam',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionItem extends StatelessWidget {
  final String text;
  const _InstructionItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(color: Color(0xFF757575), fontSize: 14),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF757575),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}