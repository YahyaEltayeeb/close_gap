import 'package:close_gap/features/academic_course/presentation/manager/academic_course_cubit.dart';
import 'package:close_gap/features/academic_course/presentation/manager/academic_course_states.dart';
import 'package:close_gap/features/academic_course/presentation/pages/explanation_screen.dart';
import 'package:close_gap/features/academic_course/presentation/pages/publish_exam_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/features/academic_course/domain/entities/publish_exam_academic_entity.dart';

import 'package:close_gap/features/academic_course/presentation/widgets/course_card.dart';

class AcademicCoursesScreen extends StatefulWidget {
  const AcademicCoursesScreen({super.key});

  @override
  State<AcademicCoursesScreen> createState() => _AcademicCoursesScreenState();
}

class _AcademicCoursesScreenState extends State<AcademicCoursesScreen> {
  int _selectedSemester = 1;
  List<PublishExamAcademicEntity> _publishedExams = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    context.read<AcademicCourseCubit>().getAcademicCourses(_selectedSemester);
    context.read<AcademicCourseCubit>().getAcademicCoursePublishedExams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF1A1A2E)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF1A1A2E)),
            onPressed: () {},
          ),
        ],
        title: const Text(
          'Academic Courses',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AcademicCourseCubit, AcademicCourseStates>(
            listenWhen: (prev, curr) =>
                curr is AcademicCoursePublishedExamsSuccess ||
                curr is AcademicCoursePublishedExamsFailure,
            listener: (context, state) {
              if (state is AcademicCoursePublishedExamsSuccess) {
                setState(() => _publishedExams = state.exams);
              }
            },
          ),
        ],
        child: Column(
          children: [
            // Header + Semester Selector
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  const Text(
                    'Discover the relative importance of your study\nmaterials to your track and also your course content.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _SemesterDropdown(
                      selected: _selectedSemester,
                      onChanged: (val) {
                        setState(() => _selectedSemester = val);
                        context.read<AcademicCourseCubit>().getAcademicCourses(
                          val,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Courses Grid
            Expanded(
              child: BlocBuilder<AcademicCourseCubit, AcademicCourseStates>(
                buildWhen: (prev, curr) =>
                    curr is GetAcademicCourseLoading ||
                    curr is GetAcademicCourseSuccess ||
                    curr is GetAcademicCourseFailure,
                builder: (context, state) {
                  if (state is GetAcademicCourseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2196F3),
                      ),
                    );
                  }

                  if (state is GetAcademicCourseFailure) {
                    return Center(
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
                            onPressed: _loadData,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is GetAcademicCourseSuccess) {
                    final courses = state.courses;
                    if (courses.isEmpty) {
                      return const Center(
                        child: Text('No courses found for this semester.'),
                      );
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.58,
                          ),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return CourseCard(
                          course: course,
                          publishedExams: _publishedExams,
                          onExplanationTap: () {
                            if (course.id != null) {
                              context
                                  .read<AcademicCourseCubit>()
                                  .getAcademicCourseExplanations(course.id!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<AcademicCourseCubit>(),
                                    child: ExplanationsScreen(
                                      courseName: course.name ?? '',
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          onPublishedExamTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<AcademicCourseCubit>(),
                                  child: const PublishedExamsScreen(),
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
            ),
          ],
        ),
      ),
    );
  }
}

class _SemesterDropdown extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const _SemesterDropdown({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selected,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.w600,
          ),
          items: List.generate(
            8,
            (i) => DropdownMenuItem(
              value: i + 1,
              child: Text('Semester ${i + 1}'),
            ),
          ),
          onChanged: (val) => val != null ? onChanged(val) : null,
        ),
      ),
    );
  }
}
