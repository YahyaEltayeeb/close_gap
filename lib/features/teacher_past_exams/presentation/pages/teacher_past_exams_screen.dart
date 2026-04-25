import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/teacher_exams/presentation/widgets/teacher_exam_shared_widgets.dart';
import 'package:close_gap/features/teacher_past_exams/presentation/manager/teacher_past_exams_cubit.dart';
import 'package:close_gap/features/teacher_past_exams/presentation/manager/teacher_past_exams_state.dart';
import 'package:close_gap/features/teacher_past_exams/presentation/widgets/teacher_exam_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherPastExamsScreen extends StatelessWidget {
  const TeacherPastExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TeacherPastExamsCubit>()..getMyExams(),
      child: BlocConsumer<TeacherPastExamsCubit, TeacherPastExamsState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ToastMessage.toastMsg(
              state.errorMessage!,
              backgroundColor: AppColors.red,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            body: SafeArea(
              child: Column(
                children: [
                  TeacherExamAppBar(
                    title: 'Past exams',
                    subtitle: 'Review all exams created by the doctor.',
                    onBackPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : state.exams.isEmpty
                        ? const _EmptyPastExamsState()
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                            itemBuilder: (context, index) {
                              final exam = state.exams[index];
                              return TeacherExamListCard(
                                exam: exam,
                                onViewResult: () {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.teacherExamResults,
                                    arguments: exam,
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 14),
                            itemCount: state.exams.length,
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
}

class _EmptyPastExamsState extends StatelessWidget {
  const _EmptyPastExamsState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.assignment_outlined, size: 64, color: Color(0xFF9CA3AF)),
            SizedBox(height: 16),
            Text(
              'No exams found yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF202124),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Once the doctor creates exams, they will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
