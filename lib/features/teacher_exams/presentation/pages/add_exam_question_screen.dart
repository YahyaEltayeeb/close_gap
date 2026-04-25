import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/components/custom_elevated_button.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/add_exam_question_request_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/exam_question_option_request_entity.dart';
import 'package:close_gap/features/teacher_exams/presentation/manager/teacher_exams_cubit.dart';
import 'package:close_gap/features/teacher_exams/presentation/manager/teacher_exams_state.dart';
import 'package:close_gap/features/teacher_exams/presentation/widgets/teacher_exam_shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExamQuestionScreen extends StatefulWidget {
  const AddExamQuestionScreen({super.key, required this.exam});

  final AcademicExamEntity exam;

  @override
  State<AddExamQuestionScreen> createState() => _AddExamQuestionScreenState();
}

class _AddExamQuestionScreenState extends State<AddExamQuestionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  late AcademicExamEntity _currentExam;
  int _correctOptionIndex = 0;
  double _questionMarks = 1;

  @override
  void initState() {
    super.initState();
    _currentExam = widget.exam;
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (final controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TeacherExamsCubit>(),
      child: BlocConsumer<TeacherExamsCubit, TeacherExamsState>(
        listenWhen: (previous, current) =>
            previous.addQuestionErrorMessage !=
                current.addQuestionErrorMessage ||
            previous.addQuestionSuccessMessage !=
                current.addQuestionSuccessMessage ||
            previous.publishExamErrorMessage !=
                current.publishExamErrorMessage ||
            previous.publishExamSuccessMessage !=
                current.publishExamSuccessMessage ||
            previous.publishedExam?.isPublished !=
                current.publishedExam?.isPublished,
        listener: (context, state) {
          if (state.addQuestionErrorMessage != null) {
            ToastMessage.toastMsg(
              state.addQuestionErrorMessage!,
              backgroundColor: AppColors.red,
            );
            context.read<TeacherExamsCubit>().clearQuestionFeedback();
          }

          if (state.addQuestionSuccessMessage != null) {
            ToastMessage.toastMsg(state.addQuestionSuccessMessage!);
            setState(() {
              _currentExam = _currentExam.copyWith(
                questionCount: state.addedQuestions.length,
              );
            });
            _resetQuestionForm();
            context.read<TeacherExamsCubit>().clearQuestionFeedback();
          }

          if (state.publishExamErrorMessage != null) {
            ToastMessage.toastMsg(
              state.publishExamErrorMessage!,
              backgroundColor: AppColors.red,
            );
            context.read<TeacherExamsCubit>().clearPublishFeedback();
          }

          if (state.publishExamSuccessMessage != null &&
              state.publishedExam != null) {
            setState(() {
              _currentExam = state.publishedExam!;
            });
            ToastMessage.toastMsg(state.publishExamSuccessMessage!);
            context.read<TeacherExamsCubit>().clearPublishFeedback();
          }
        },
        builder: (context, state) {
          final exam = state.publishedExam ?? _currentExam;
          final totalQuestions =
              state.addedQuestions.length > exam.questionCount
              ? state.addedQuestions.length
              : exam.questionCount;

          return Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            body: SafeArea(
              child: Column(
                children: [
                  TeacherExamAppBar(
                    title: 'Add new exam',
                    subtitle: 'Create a new exam to test the students.',
                    onBackPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TeacherExamCard(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${exam.title} - ${exam.academicCourseName} (${_labelizeExamType(exam.examType)})',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        exam.isPublished
                                            ? Icons.check_circle
                                            : Icons.expand_less_rounded,
                                        color: exam.isPublished
                                            ? Colors.green
                                            : const Color(0xFF787878),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _ExamStat(
                                        label: 'Questions',
                                        value: '$totalQuestions',
                                      ),
                                      _ExamStat(
                                        label: 'Durations',
                                        value: '${exam.durationMinutes} min',
                                      ),
                                      _ExamStat(
                                        label: 'Passing score',
                                        value:
                                            '${exam.passingScore.toStringAsFixed(2)}%',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Questions added so far:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  if (state.addedQuestions.isEmpty)
                                    const Text(
                                      'No questions added yet.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF777777),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ...state.addedQuestions.map(
                                    (question) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFFD7D7D7),
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x12000000),
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          '${question.order + 1}. ${question.text}\n- MCQ - ${question.marks.toStringAsFixed(1)} mark(s)',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            TeacherExamCard(
                              padding: const EdgeInsets.all(14),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFF8C8C8C),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.add,
                                          color: Colors.red,
                                          size: 28,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Add Question',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    const Text(
                                      'Question Text',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: const Color(0xFF909090),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: _questionController,
                                        minLines: 3,
                                        maxLines: 5,
                                        decoration: const InputDecoration(
                                          hintText: '|',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(12),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Please enter question text';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Type',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x12000000),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: DropdownButton<String>(
                                        value: 'MCQ',
                                        isExpanded: true,
                                        underline: const SizedBox.shrink(),
                                        items: const [
                                          DropdownMenuItem(
                                            value: 'MCQ',
                                            child: Text('MCQ'),
                                          ),
                                        ],
                                        onChanged: null,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: 170,
                                      child: TeacherExamCounterField(
                                        label: 'Marks',
                                        value: _questionMarks.toStringAsFixed(
                                          2,
                                        ),
                                        onIncrement: () {
                                          setState(() {
                                            _questionMarks += 1;
                                          });
                                        },
                                        onDecrement: () {
                                          if (_questionMarks <= 1) {
                                            return;
                                          }
                                          setState(() {
                                            _questionMarks -= 1;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Options',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    ...List.generate(_optionControllers.length, (
                                      index,
                                    ) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: TeacherExamCard(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _correctOptionIndex = index;
                                                  });
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  height: 24,
                                                  width: 24,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          _correctOptionIndex ==
                                                              index
                                                          ? AppColors
                                                                .lightPrimary
                                                          : const Color(
                                                              0xFFB8B8B8,
                                                            ),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            _correctOptionIndex ==
                                                                index
                                                            ? AppColors
                                                                  .lightPrimary
                                                            : Colors
                                                                  .transparent,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: TextFormField(
                                                  controller:
                                                      _optionControllers[index],
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Option ${index + 1}',
                                                    border: InputBorder.none,
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Please enter option ${index + 1}';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                    const SizedBox(height: 10),
                                    CustomElevatedButton(
                                      isLoading: state.isAddingQuestion,
                                      onPressed: () {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }

                                        final options = List.generate(
                                          _optionControllers.length,
                                          (index) =>
                                              ExamQuestionOptionRequestEntity(
                                                text: _optionControllers[index]
                                                    .text
                                                    .trim(),
                                                isCorrect:
                                                    index ==
                                                    _correctOptionIndex,
                                              ),
                                        );

                                        context
                                            .read<TeacherExamsCubit>()
                                            .addQuestion(
                                              AddExamQuestionRequestEntity(
                                                examId: exam.id,
                                                text: _questionController.text
                                                    .trim(),
                                                marks: _questionMarks,
                                                options: options,
                                              ),
                                            );
                                      },
                                      widget: const Text(
                                        'Add Question',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            const Row(
                              children: [
                                Icon(
                                  Icons.rocket_launch_rounded,
                                  size: 24,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Publish',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              exam.isPublished
                                  ? 'Exam is live now for students.'
                                  : 'Students can take it after publishing',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4D4D4D),
                              ),
                            ),
                            const SizedBox(height: 14),
                            CustomElevatedButton(
                              isLoading: state.isPublishingExam,
                              onPressed: () {
                                if (exam.isPublished) {
                                  ToastMessage.toastMsg(
                                    'Exam already published',
                                  );
                                  return;
                                }
                                if (totalQuestions == 0) {
                                  ToastMessage.toastMsg(
                                    'Add at least one question before publishing',
                                    backgroundColor: AppColors.red,
                                  );
                                  return;
                                }
                                context.read<TeacherExamsCubit>().publishExam(
                                  exam.id,
                                );
                              },
                              widget: Text(
                                exam.isPublished ? 'Published' : 'Publish',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _resetQuestionForm() {
    _questionController.clear();
    for (final controller in _optionControllers) {
      controller.clear();
    }
    setState(() {
      _correctOptionIndex = 0;
      _questionMarks = 1;
    });
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

class _ExamStat extends StatelessWidget {
  const _ExamStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF444444),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.lightPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
