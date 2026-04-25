import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/features/academic_course/domain/entities/academic_exam_results_entity.dart';

import 'package:close_gap/features/academic_course/presentation/manager/academic_course_cubit.dart';
import 'package:close_gap/features/academic_course/presentation/manager/academic_course_states.dart';
import 'package:close_gap/features/academic_course/presentation/pages/academic_course_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcademicExamResultScreen extends StatefulWidget {
  final int examId;
  final String courseName;

  const AcademicExamResultScreen({
    super.key,
    required this.examId,
    required this.courseName,
  });

  @override
  State<AcademicExamResultScreen> createState() =>
      _AcademicExamResultScreenState();
}

class _AcademicExamResultScreenState extends State<AcademicExamResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AcademicCourseCubit>().getAcademicExamResult();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: BlocBuilder<AcademicCourseCubit, AcademicCourseStates>(
          buildWhen: (prev, curr) =>
              curr is GetAcademicExamResultLoading ||
              curr is GetAcademicExamResultSuccess ||
              curr is GetAcademicExamResultFailure,
          builder: (context, state) {
            if (state is GetAcademicExamResultLoading) {
              return const CircularProgressIndicator(color: Colors.white);
            }

            if (state is GetAcademicExamResultFailure) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context
                          .read<AcademicCourseCubit>()
                          .getAcademicExamResult(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is GetAcademicExamResultSuccess) {
              final result = state.examResults
                  .where((e) => e.examId == widget.examId)
                  .toList();
              final examResult = result.isNotEmpty ? result.first : null;

              return _ResultCard(
                examResult: examResult,
                courseName: widget.courseName,
              );
            }

            return const CircularProgressIndicator(color: Colors.white);
          },
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final AcademicExamResultsEntity? examResult;
  final String courseName;

  const _ResultCard({required this.examResult, required this.courseName});

  bool get _isPendingGrading {
    final status = examResult?.status;
    return status == 'submitted' ||
        status == 'pending' ||
        examResult?.finalScore == null;
  }

  double? get _finalScore {
    final score = examResult?.finalScore;
    if (score == null) return null;
    return double.tryParse(score.toString());
  }

  bool get _passed => (_finalScore ?? 0) >= 50;

  List<Color> get _gradientColors {
    if (_isPendingGrading) {
      return [const Color(0xFF1565C0), const Color(0xFF42A5F5)];
    }
    final score = _finalScore ?? 0;
    if (score >= 75) return [const Color(0xFF2E7D32), const Color(0xFF66BB6A)];
    if (score >= 50) return [const Color(0xFFE65100), const Color(0xFFFFA726)];
    return [const Color(0xFFC62828), const Color(0xFFEF5350)];
  }

  String get _resultTitle {
    if (_isPendingGrading) return 'Answers submitted\nsuccessfully!';
    final score = _finalScore ?? 0;
    if (score >= 75) return 'Congratulations!';
    if (score >= 50) return 'Passed!';
    return 'Not Passed!';
  }

  String get _resultSubtitle {
    if (_isPendingGrading) {
      return 'Your instructor will review your\nanswers and assign a grade.\nYou will be able to see your score\nafter grading is complete.';
    }
    final score = _finalScore ?? 0;
    if (score >= 50) return 'You passed with ${score.toStringAsFixed(1)}%';
    return "You don't pass your score ${score.toStringAsFixed(1)}%";
  }

  IconData get _resultIcon {
    if (_isPendingGrading) return Icons.hourglass_bottom_rounded;
    final score = _finalScore ?? 0;
    if (score >= 75) return Icons.emoji_events_rounded;
    if (score >= 50) return Icons.bar_chart_rounded;
    return Icons.menu_book_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close Button
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 12),
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF757575),
                  size: 22,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Exam Result',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 16),
          // Gradient Result Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(_resultIcon, color: Colors.white, size: 52),
                  const SizedBox(height: 12),
                  Text(
                    _resultTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _resultSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatItem(label: 'Exam', value: examResult?.examTitle ?? '-'),
                _StatItem(
                  label: 'Status',
                  value: _isPendingGrading
                      ? 'Pending Grading'
                      : _passed
                      ? 'Passed'
                      : 'Failed',
                  valueColor: _isPendingGrading
                      ? const Color(0xFF1565C0)
                      : _passed
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFFC62828),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          const SizedBox(height: 16),
          // Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                if (!_isPendingGrading) ...[
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2196F3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Review Answers',
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) =>
                                getIt<AcademicCourseCubit>()
                                  ..getAcademicCoursePublishedExams(),
                            child: const AcademicCoursesScreen(),
                          ),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Back to Academic Courses',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _StatItem({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: valueColor ?? const Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}
