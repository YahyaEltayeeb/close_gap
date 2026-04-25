import 'dart:async';
import 'package:close_gap/features/academic_course/data/models/request/submission_exam_request.dart';
import 'package:close_gap/features/academic_course/data/models/response/start_exam_dto.dart';
import 'package:close_gap/features/academic_course/domain/entities/start_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/presentation/manager/academic_course_cubit.dart';
import 'package:close_gap/features/academic_course/presentation/manager/academic_course_states.dart';
import 'package:close_gap/features/academic_course/presentation/pages/academic_exam_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcademicExamScreen extends StatefulWidget {
  final StartExamAcademicEntity examData;
  final String courseName;
  final int examId;

  const AcademicExamScreen({
    super.key,
    required this.examData,
    required this.courseName,
    required this.examId,
  });

  @override
  State<AcademicExamScreen> createState() => _AcademicExamScreenState();
}

class _AcademicExamScreenState extends State<AcademicExamScreen> {
  int _currentIndex = 0;
  late int _remainingSeconds;
  Timer? _timer;
  bool _isSubmitting = false;

  final Map<int, int> _answers = {};

  List<Question> get _questions => widget.examData.questions ?? [];

  @override
  void initState() {
    super.initState();
    _remainingSeconds = 30 * 60;

    if (_questions.isNotEmpty) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        _submitExam();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _goToResultScreen() {
    _timer?.cancel();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<AcademicCourseCubit>(),
          child: AcademicExamResultScreen(
            examId: widget.examId,
            courseName: widget.courseName,
          ),
        ),
      ),
    );
  }

  void _submitExam() {
    if (_isSubmitting) return;

    _timer?.cancel();

    if (_questions.isEmpty) {
      _goToResultScreen();
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final answers = _answers.entries
        .map((e) => Answer(questionId: e.key, chosenOptionId: e.value))
        .toList();

    final request = SubmissionExamRequest(
      submissionId: widget.examData.submissionId,
      answers: answers,
    );

    context.read<AcademicCourseCubit>().submitAcademicExam(
          widget.examId,
          request,
        );
  }

  String get _timerText {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AcademicCourseCubit, AcademicCourseStates>(
      listenWhen: (_, curr) =>
          curr is SubmitAcademicExamSuccess ||
          curr is SubmitAcademicExamFailure,
      listener: (context, state) {
        if (state is SubmitAcademicExamSuccess) {
          _goToResultScreen();
        } else if (state is SubmitAcademicExamFailure) {
          setState(() {
            _isSubmitting = false;
          });

          if (_questions.isNotEmpty) {
            _startTimer();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 16,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer, color: Colors.white, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    _questions.isEmpty ? '--:--' : _timerText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: _isSubmitting ? null : _submitExam,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _isSubmitting
                          ? Colors.grey
                          : const Color(0xFF2196F3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'End Exam',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
          body: _questions.isEmpty
              ? _AlreadyCompletedBody(
                  courseName: widget.courseName,
                  onViewResult: _goToResultScreen,
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Exam: ${widget.courseName}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Complete the following questions to finish your assessment',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Question ${_currentIndex + 1} of ${_questions.length}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _QuestionCard(
                          question: _questions[_currentIndex],
                          selectedOptionId:
                              _answers[_questions[_currentIndex].id],
                          onOptionSelected: (optionId) {
                            final questionId = _questions[_currentIndex].id;
                            if (questionId == null) return;

                            setState(() {
                              _answers[questionId] = optionId;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _currentIndex > 0 && !_isSubmitting
                                  ? () => setState(() => _currentIndex--)
                                  : null,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF2196F3),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text(
                                'Previous',
                                style: TextStyle(
                                  color: Color(0xFF2196F3),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _isSubmitting
                                  ? null
                                  : () {
                                      if (_currentIndex <
                                          _questions.length - 1) {
                                        setState(() => _currentIndex++);
                                      } else {
                                        _submitExam();
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2196F3),
                                disabledBackgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                elevation: 0,
                              ),
                              child: Text(
                                _currentIndex < _questions.length - 1
                                    ? 'Next'
                                    : 'Submit',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Question Navigator',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF757575),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                _questions.length,
                                (i) {
                                  final questionId = _questions[i].id;
                                  final isCurrent = i == _currentIndex;
                                  final isAnswered = questionId != null &&
                                      _answers.containsKey(questionId);

                                  return GestureDetector(
                                    onTap: _isSubmitting
                                        ? null
                                        : () {
                                            setState(() {
                                              _currentIndex = i;
                                            });
                                          },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: isCurrent
                                            ? const Color(0xFF2196F3)
                                            : isAnswered
                                                ? const Color(0xFFE3F2FD)
                                                : const Color(0xFFF5F7FA),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: isCurrent
                                              ? const Color(0xFF2196F3)
                                              : const Color(0xFFE0E0E0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${i + 1}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: isCurrent
                                                ? Colors.white
                                                : const Color(0xFF1A1A2E),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _AlreadyCompletedBody extends StatelessWidget {
  final String courseName;
  final VoidCallback onViewResult;

  const _AlreadyCompletedBody({
    required this.courseName,
    required this.onViewResult,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF2196F3),
                size: 56,
              ),
              const SizedBox(height: 16),
              Text(
                'Exam: $courseName',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'You have already completed this exam.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onViewResult,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'View Result',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final Question question;
  final int? selectedOptionId;
  final ValueChanged<int> onOptionSelected;

  const _QuestionCard({
    required this.question,
    required this.selectedOptionId,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final options = question.options ?? [];

    return Container(
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.text ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.black,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            ...options.map(
              (option) {
                final isSelected = selectedOptionId == option.id;

                return GestureDetector(
                  onTap: () {
                    if (option.id != null) {
                      onOptionSelected(option.id!);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE3F2FD)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2196F3)
                            : const Color(0xFFE0E0E0),
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2196F3)
                                  : const Color(0xFFBDBDBD),
                              width: 2,
                            ),
                            color: isSelected
                                ? const Color(0xFF2196F3)
                                : Colors.white,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option.text ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? const Color(0xFF2196F3)
                                  : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}