import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/routing/routing_extensions.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/components/custom_elevated_button.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/create_exam_request_entity.dart';
import 'package:close_gap/features/teacher_exams/presentation/manager/teacher_exams_cubit.dart';
import 'package:close_gap/features/teacher_exams/presentation/manager/teacher_exams_state.dart';
import 'package:close_gap/features/teacher_exams/presentation/widgets/teacher_exam_shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateExamScreen extends StatefulWidget {
  const CreateExamScreen({super.key});

  @override
  State<CreateExamScreen> createState() => _CreateExamScreenState();
}

class _CreateExamScreenState extends State<CreateExamScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  AcademicCourseEntity? _selectedCourse;
  String _selectedExamType = 'midterm';
  double _passingScore = 50;
  double _totalMarks = 100;
  int _durationMinutes = 90;
  late DateTime _startsAt;
  late DateTime _endsAt;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startsAt = DateTime(now.year, now.month, now.day, 9);
    _endsAt = _startsAt.add(const Duration(hours: 2));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TeacherExamsCubit>()..loadAcademicCourses(),
      child: BlocConsumer<TeacherExamsCubit, TeacherExamsState>(
        listenWhen: (previous, current) =>
            previous.createExamErrorMessage != current.createExamErrorMessage ||
            previous.createdExam?.id != current.createdExam?.id ||
            previous.coursesErrorMessage != current.coursesErrorMessage,
        listener: (context, state) {
          if (state.coursesErrorMessage != null) {
            ToastMessage.toastMsg(
              state.coursesErrorMessage!,
              backgroundColor: AppColors.red,
            );
          }

          if (state.createExamErrorMessage != null) {
            ToastMessage.toastMsg(
              state.createExamErrorMessage!,
              backgroundColor: AppColors.red,
            );
          }

          if (state.createdExam != null) {
            ToastMessage.toastMsg('Exam created successfully');
            context.pushReplacementNamed(
              AppRoutes.addExamQuestion,
              arguments: state.createdExam,
            );
          }
        },
        builder: (context, state) {
          if (_selectedCourse == null && state.courses.isNotEmpty) {
            _selectedCourse = state.courses.first;
          }

          return Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            body: SafeArea(
              child: Column(
                children: [
                  TeacherExamAppBar(
                    title: 'Add new exam',
                    subtitle: 'Create a new exam to test the students.',
                    onBackPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TeacherExamSectionIcon(
                              icon: Icons.menu_book_rounded,
                            ),
                            const SizedBox(height: 12),
                            TeacherExamCard(
                              child:
                                  DropdownButtonFormField<AcademicCourseEntity>(
                                    initialValue: _selectedCourse,
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    hint: Text(
                                      state.isCoursesLoading
                                          ? 'Loading courses...'
                                          : 'Select course',
                                    ),
                                    items: state.courses
                                        .map(
                                          (course) =>
                                              DropdownMenuItem<
                                                AcademicCourseEntity
                                              >(
                                                value: course,
                                                child: Text(
                                                  course.displayName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                        )
                                        .toList(),
                                    onChanged: state.isCoursesLoading
                                        ? null
                                        : (value) {
                                            setState(() {
                                              _selectedCourse = value;
                                            });
                                          },
                                    validator: (value) => value == null
                                        ? 'Please select a course'
                                        : null,
                                  ),
                            ),
                            const SizedBox(height: 18),
                            const TeacherExamSectionIcon(
                              icon: Icons.edit_note_rounded,
                            ),
                            const SizedBox(height: 12),
                            TeacherExamCard(
                              child: TextFormField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  hintText: 'AI exam',
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter exam title';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 14),
                            TeacherExamCard(
                              child: DropdownButtonFormField<String>(
                                initialValue: _selectedExamType,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'midterm',
                                    child: Text('Midterm'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'final',
                                    child: Text('Final'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'quiz',
                                    child: Text('Quiz'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'assignment',
                                    child: Text('Assignment'),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    _selectedExamType = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 14),
                            TeacherExamCard(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _notesController,
                                minLines: 4,
                                maxLines: 6,
                                decoration: const InputDecoration(
                                  hintText: 'Notes or instructions (optional)',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TeacherExamCounterField(
                                    label: 'Duration (min)',
                                    value: _durationMinutes.toString(),
                                    onIncrement: () {
                                      setState(() {
                                        _durationMinutes += 15;
                                      });
                                    },
                                    onDecrement: () {
                                      if (_durationMinutes <= 15) {
                                        return;
                                      }
                                      setState(() {
                                        _durationMinutes -= 15;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TeacherExamCounterField(
                                    label: 'Passing score (%)',
                                    value: _formatDouble(_passingScore),
                                    onIncrement: () {
                                      if (_passingScore >= 100) {
                                        return;
                                      }
                                      setState(() {
                                        _passingScore += 5;
                                      });
                                    },
                                    onDecrement: () {
                                      if (_passingScore <= 0) {
                                        return;
                                      }
                                      setState(() {
                                        _passingScore -= 5;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: context.width * 0.42,
                              child: TeacherExamCounterField(
                                label: 'Total marks',
                                value: _formatDouble(_totalMarks),
                                onIncrement: () {
                                  setState(() {
                                    _totalMarks += 5;
                                  });
                                },
                                onDecrement: () {
                                  if (_totalMarks <= 5) {
                                    return;
                                  }
                                  setState(() {
                                    _totalMarks -= 5;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 18),
                            const TeacherExamSectionIcon(
                              icon: Icons.calendar_month_rounded,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _DateTimeCard(
                                    label: 'Starts At',
                                    value: _formatDateTime(_startsAt),
                                    onTap: () async {
                                      final value = await _pickDateTime(
                                        _startsAt,
                                      );
                                      if (value != null) {
                                        setState(() {
                                          _startsAt = value;
                                          if (!_endsAt.isAfter(_startsAt)) {
                                            _endsAt = _startsAt.add(
                                              const Duration(hours: 2),
                                            );
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _DateTimeCard(
                                    label: 'Ends At',
                                    value: _formatDateTime(_endsAt),
                                    onTap: () async {
                                      final value = await _pickDateTime(
                                        _endsAt,
                                      );
                                      if (value != null) {
                                        setState(() {
                                          _endsAt = value;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 26),
                            CustomElevatedButton(
                              isLoading: state.isCreatingExam,
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                if (_selectedCourse == null) {
                                  ToastMessage.toastMsg(
                                    'Please select a course',
                                    backgroundColor: AppColors.red,
                                  );
                                  return;
                                }
                                if (!_endsAt.isAfter(_startsAt)) {
                                  ToastMessage.toastMsg(
                                    'End time must be after start time',
                                    backgroundColor: AppColors.red,
                                  );
                                  return;
                                }

                                context.read<TeacherExamsCubit>().createExam(
                                  CreateExamRequestEntity(
                                    academicCourseId: _selectedCourse!.id,
                                    title: _titleController.text.trim(),
                                    examType: _selectedExamType,
                                    durationMinutes: _durationMinutes,
                                    passingScore: _passingScore,
                                    totalMarks: _totalMarks,
                                    startsAt: _formatDateTime(_startsAt),
                                    endsAt: _formatDateTime(_endsAt),
                                  ),
                                );
                              },
                              widget: const Text(
                                'Create Exam',
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<DateTime?> _pickDateTime(DateTime initialValue) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialValue,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (pickedDate == null || !mounted) {
      return null;
    }

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialValue),
    );
    if (pickedTime == null) {
      return null;
    }

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  String _formatDouble(double value) => value.toStringAsFixed(2);

  String _formatDateTime(DateTime value) {
    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    final second = value.second.toString().padLeft(2, '0');
    return '$year-$month-${day}T$hour:$minute:$second';
  }
}

class _DateTimeCard extends StatelessWidget {
  const _DateTimeCard({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: TeacherExamCard(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 18,
                  color: AppColors.lightPrimary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
