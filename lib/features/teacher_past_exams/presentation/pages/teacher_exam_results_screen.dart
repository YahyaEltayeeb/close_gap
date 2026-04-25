import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/teacher_exams/presentation/widgets/teacher_exam_shared_widgets.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_list_item_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_question_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_results_overview_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_submission_entity.dart';
import 'package:close_gap/features/teacher_past_exams/presentation/manager/teacher_exam_results_cubit.dart';
import 'package:close_gap/features/teacher_past_exams/presentation/manager/teacher_exam_results_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherExamResultsScreen extends StatelessWidget {
  const TeacherExamResultsScreen({super.key, required this.exam});

  final TeacherExamListItemEntity exam;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TeacherExamResultsCubit>()..loadExamData(exam.id),
      child: _TeacherExamResultsView(exam: exam),
    );
  }
}

class _TeacherExamResultsView extends StatefulWidget {
  const _TeacherExamResultsView({required this.exam});

  final TeacherExamListItemEntity exam;

  @override
  State<_TeacherExamResultsView> createState() =>
      _TeacherExamResultsViewState();
}

class _TeacherExamResultsViewState extends State<_TeacherExamResultsView> {
  final Map<int, TextEditingController> _feedbackControllers = {};

  @override
  void dispose() {
    for (final controller in _feedbackControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherExamResultsCubit, TeacherExamResultsState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ToastMessage.toastMsg(
            state.errorMessage!,
            backgroundColor: AppColors.red,
          );
          context.read<TeacherExamResultsCubit>().clearFeedback();
        }
        if (state.successMessage != null) {
          ToastMessage.toastMsg(state.successMessage!);
          context.read<TeacherExamResultsCubit>().clearFeedback();
        }
      },
      builder: (context, state) {
        final overview = state.overview;
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          body: SafeArea(
            child: Column(
              children: [
                TeacherExamAppBar(
                  title: 'Grade submissions',
                  subtitle:
                      'Course: ${widget.exam.academicCourseName} - Exam: ${widget.exam.title}',
                  onBackPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : overview == null
                      ? const _EmptyResultsState()
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                          child: Column(
                            children: [
                              _OverviewStrip(overview: overview),
                              const SizedBox(height: 16),
                              ...overview.results.map(
                                (result) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _SubmissionTile(
                                    result: result,
                                    submission: _findSubmission(
                                      result.submissionId,
                                      state.submissions,
                                    ),
                                    questions: state.questions,
                                    isExpanded:
                                        state.expandedSubmissionId ==
                                        result.submissionId,
                                    currentQuestionIndex:
                                        state.currentQuestionIndex,
                                    isSubmittingGrades:
                                        state.isSubmittingGrades,
                                    feedbackControllerForAnswer:
                                        _feedbackControllerForAnswer,
                                    onToggle: () => context
                                        .read<TeacherExamResultsCubit>()
                                        .toggleSubmission(result.submissionId),
                                    onNextQuestion: () => context
                                        .read<TeacherExamResultsCubit>()
                                        .nextQuestion(),
                                    onPreviousQuestion: () => context
                                        .read<TeacherExamResultsCubit>()
                                        .previousQuestion(),
                                    onSubmitGrades: () => _submitGrades(
                                      context,
                                      widget.exam.id,
                                      _findSubmission(
                                        result.submissionId,
                                        state.submissions,
                                      ),
                                    ),
                                    onViewAnswers: () => _showAnswersSheet(
                                      context,
                                      result,
                                      _findSubmission(
                                        result.submissionId,
                                        state.submissions,
                                      ),
                                      state.questions,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TeacherExamSubmissionEntity? _findSubmission(
    int submissionId,
    List<TeacherExamSubmissionEntity> submissions,
  ) {
    for (final submission in submissions) {
      if (submission.submissionId == submissionId) return submission;
    }
    return null;
  }

  TeacherExamQuestionEntity? _findQuestionForAnswer(
    TeacherExamSubmissionAnswerEntity answer,
    List<TeacherExamQuestionEntity> questions,
  ) {
    for (final question in questions) {
      if (question.id == answer.questionId) return question;
    }
    return null;
  }

  TextEditingController _feedbackControllerForAnswer(
    TeacherExamSubmissionAnswerEntity? answer,
  ) {
    final answerId = answer?.answerId ?? -1;
    return _feedbackControllers.putIfAbsent(answerId, () {
      return TextEditingController(text: answer?.feedback ?? '');
    });
  }

  void _submitGrades(
    BuildContext context,
    int examId,
    TeacherExamSubmissionEntity? submission,
  ) {
    if (submission == null || submission.answers.isEmpty) {
      ToastMessage.toastMsg(
        'No answers found for this submission',
        backgroundColor: AppColors.red,
      );
      return;
    }

    final grades = <({int answerId, double? score, String? feedback})>[];
    for (final answer in submission.answers) {
      final question = _findQuestionForAnswer(
        answer,
        context.read<TeacherExamResultsCubit>().state.questions,
      );
      final questionLabel =
          question == null ? 'this question' : 'question ${question.order + 1}';
      final feedback = _feedbackControllerForAnswer(answer).text.trim();
      if (feedback.isEmpty) {
        ToastMessage.toastMsg(
          'Please enter feedback for $questionLabel before submitting',
          backgroundColor: AppColors.red,
        );
        return;
      }

      grades.add((
        answerId: answer.answerId,
        score: null,
        feedback: feedback,
      ));
    }

    context.read<TeacherExamResultsCubit>().submitGrades(examId, grades);
  }

  void _showAnswersSheet(
    BuildContext context,
    TeacherExamResultStudentEntity result,
    TeacherExamSubmissionEntity? submission,
    List<TeacherExamQuestionEntity> questions,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.55,
          maxChildSize: 0.95,
          builder: (context, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView.builder(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                itemCount: questions.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          Container(
                            width: 44,
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1D5DB),
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            result.studentName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Score: ${_formatScore(result.finalScore)} / ${widget.exam.questionCount}',
                            style: const TextStyle(
                              color: Color(0xFF4B5563),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final question = questions[index - 1];
                  final answer = _answerForQuestion(
                    question,
                    submission,
                    index - 1,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _AnswerReviewCard(
                      questionNumber: question.order + 1,
                      question: question,
                      answer: answer,
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  TeacherExamSubmissionAnswerEntity? _answerForQuestion(
    TeacherExamQuestionEntity question,
    TeacherExamSubmissionEntity? submission,
    int fallbackIndex,
  ) {
    if (submission == null) return null;

    for (final answer in submission.answers) {
      if (answer.questionId != null && answer.questionId == question.id) {
        return answer;
      }
    }

    for (final answer in submission.answers) {
      if (answer.questionText.isNotEmpty &&
          answer.questionText == question.text) {
        return answer;
      }
    }

    if (fallbackIndex < submission.answers.length) {
      return submission.answers[fallbackIndex];
    }

    return null;
  }

  String _formatScore(double? score) {
    if (score == null) return '--';
    if (score == score.roundToDouble()) return score.toStringAsFixed(0);
    return score.toStringAsFixed(1);
  }
}

class _OverviewStrip extends StatelessWidget {
  const _OverviewStrip({required this.overview});

  final TeacherExamResultsOverviewEntity overview;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Submissions',
            value: '${overview.totalSubmissions}',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(label: 'Passed', value: '${overview.passedCount}'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            label: 'Questions',
            value: '${overview.exam.questionCount}',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmissionTile extends StatelessWidget {
  const _SubmissionTile({
    required this.result,
    required this.submission,
    required this.questions,
    required this.isExpanded,
    required this.currentQuestionIndex,
    required this.isSubmittingGrades,
    required this.feedbackControllerForAnswer,
    required this.onToggle,
    required this.onNextQuestion,
    required this.onPreviousQuestion,
    required this.onSubmitGrades,
    required this.onViewAnswers,
  });

  final TeacherExamResultStudentEntity result;
  final TeacherExamSubmissionEntity? submission;
  final List<TeacherExamQuestionEntity> questions;
  final bool isExpanded;
  final int currentQuestionIndex;
  final bool isSubmittingGrades;
  final TextEditingController Function(TeacherExamSubmissionAnswerEntity?)
  feedbackControllerForAnswer;
  final VoidCallback onToggle;
  final VoidCallback onNextQuestion;
  final VoidCallback onPreviousQuestion;
  final VoidCallback onSubmitGrades;
  final VoidCallback onViewAnswers;

  @override
  Widget build(BuildContext context) {
    final bool isGraded = result.isGraded;
    final bool hasNextQuestion = currentQuestionIndex < questions.length - 1;
    final TeacherExamQuestionEntity? question =
        questions.isEmpty || currentQuestionIndex >= questions.length
        ? null
        : questions[currentQuestionIndex];
    final TeacherExamSubmissionAnswerEntity? answer = question == null
        ? null
        : _matchAnswer(question);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: isGraded ? null : onToggle,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  const Icon(Icons.person, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result.studentName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColors.lightPrimary,
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isGraded ? 'Graded' : 'Needs Grading',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isGraded) ...[
                    Text(
                      'Score: ${_formatScore(result.finalScore)}/${questions.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 118,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: onViewAnswers,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'View Answers',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ] else
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 28,
                    ),
                ],
              ),
            ),
          ),
          if (!isGraded && isExpanded && question != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                children: [
                  const Divider(height: 1),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Question ${currentQuestionIndex + 1}/${questions.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _QuestionGradeCard(
                    questionNumber: question.order + 1,
                    question: question,
                    answer: answer,
                    feedbackController: feedbackControllerForAnswer(answer),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: hasNextQuestion
                                ? onNextQuestion
                                : onPreviousQuestion,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              hasNextQuestion
                                  ? 'Next Question'
                                  : 'Previous Question',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: isSubmittingGrades
                                ? null
                                : onSubmitGrades,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightPrimary,
                              disabledBackgroundColor: const Color(0xFF9CA3AF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isSubmittingGrades
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Submit Grades',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  TeacherExamSubmissionAnswerEntity? _matchAnswer(
    TeacherExamQuestionEntity question,
  ) {
    if (submission == null) return null;

    for (final answer in submission!.answers) {
      if (answer.questionId != null && answer.questionId == question.id) {
        return answer;
      }
    }

    for (final answer in submission!.answers) {
      if (answer.questionText.isNotEmpty &&
          answer.questionText == question.text) {
        return answer;
      }
    }

    if (currentQuestionIndex < submission!.answers.length) {
      return submission!.answers[currentQuestionIndex];
    }

    return null;
  }

  String _formatScore(double? score) {
    if (score == null) return '--';
    if (score == score.roundToDouble()) return score.toStringAsFixed(0);
    return score.toStringAsFixed(1);
  }
}

class _QuestionGradeCard extends StatelessWidget {
  const _QuestionGradeCard({
    required this.questionNumber,
    required this.question,
    required this.answer,
    required this.feedbackController,
  });

  final int questionNumber;
  final TeacherExamQuestionEntity question;
  final TeacherExamSubmissionAnswerEntity? answer;
  final TextEditingController feedbackController;

  @override
  Widget build(BuildContext context) {
    final correctOption = question.options.where(
      (option) => option.id == question.correctOptionId,
    );
    final correctAnswerText = correctOption.isEmpty
        ? ''
        : correctOption.first.text;
    final studentAnswerText = answer?.openAnswerText.isNotEmpty == true
        ? answer!.openAnswerText
        : answer?.chosenOptionText.isNotEmpty == true
        ? answer!.chosenOptionText
        : 'No answer submitted';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$questionNumber. ${question.text}',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Type: ${question.questionType.toUpperCase()} | Mark(s): ${question.marks}',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
          if (correctAnswerText.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text(
              'Correct Answer',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            _InfoField(text: correctAnswerText),
          ],
          const SizedBox(height: 12),
          const Text(
            'Student Answer',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          _InfoField(text: studentAnswerText),
          const SizedBox(height: 12),
          const Text(
            'Feedback',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          _EditableField(
            controller: feedbackController,
            hint: 'Feedback is required',
          ),
        ],
      ),
    );
  }
}

class _AnswerReviewCard extends StatelessWidget {
  const _AnswerReviewCard({
    required this.questionNumber,
    required this.question,
    required this.answer,
  });

  final int questionNumber;
  final TeacherExamQuestionEntity question;
  final TeacherExamSubmissionAnswerEntity? answer;

  @override
  Widget build(BuildContext context) {
    final correctOption = question.options.where(
      (option) => option.id == question.correctOptionId,
    );
    final correctAnswerText = correctOption.isEmpty
        ? ''
        : correctOption.first.text;
    final studentAnswerText = answer?.openAnswerText.isNotEmpty == true
        ? answer!.openAnswerText
        : answer?.chosenOptionText.isNotEmpty == true
        ? answer!.chosenOptionText
        : 'No answer submitted';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question $questionNumber',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            question.text,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          if (correctAnswerText.isNotEmpty) ...[
            const Text(
              'Correct Answer',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            _InfoField(text: correctAnswerText),
            const SizedBox(height: 12),
          ],
          const Text(
            'Student Answer',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          _InfoField(text: studentAnswerText),
          if (answer?.score != null || (answer?.feedback ?? '').isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Score: ${answer?.score?.toStringAsFixed(2) ?? '--'}',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            if ((answer?.feedback ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Feedback: ${answer!.feedback}',
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  const _EditableField({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: hint == 'Feedback is required' ? 2 : 1,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.lightPrimary),
        ),
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _EmptyResultsState extends StatelessWidget {
  const _EmptyResultsState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No submissions found for this exam',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
