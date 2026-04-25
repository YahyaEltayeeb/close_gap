import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_question_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_results_overview_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_submission_entity.dart';

class TeacherExamResultsState {
  static const _sentinel = Object();

  final bool isLoading;
  final bool isSubmittingGrades;
  final String? errorMessage;
  final String? successMessage;
  final TeacherExamResultsOverviewEntity? overview;
  final List<TeacherExamQuestionEntity> questions;
  final List<TeacherExamSubmissionEntity> submissions;
  final int? expandedSubmissionId;
  final int currentQuestionIndex;

  const TeacherExamResultsState({
    this.isLoading = false,
    this.isSubmittingGrades = false,
    this.errorMessage,
    this.successMessage,
    this.overview,
    this.questions = const [],
    this.submissions = const [],
    this.expandedSubmissionId,
    this.currentQuestionIndex = 0,
  });

  TeacherExamResultsState copyWith({
    bool? isLoading,
    bool? isSubmittingGrades,
    Object? errorMessage = _sentinel,
    Object? successMessage = _sentinel,
    Object? overview = _sentinel,
    List<TeacherExamQuestionEntity>? questions,
    List<TeacherExamSubmissionEntity>? submissions,
    Object? expandedSubmissionId = _sentinel,
    int? currentQuestionIndex,
  }) {
    return TeacherExamResultsState(
      isLoading: isLoading ?? this.isLoading,
      isSubmittingGrades: isSubmittingGrades ?? this.isSubmittingGrades,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      successMessage: identical(successMessage, _sentinel)
          ? this.successMessage
          : successMessage as String?,
      overview: identical(overview, _sentinel)
          ? this.overview
          : overview as TeacherExamResultsOverviewEntity?,
      questions: questions ?? this.questions,
      submissions: submissions ?? this.submissions,
      expandedSubmissionId: identical(expandedSubmissionId, _sentinel)
          ? this.expandedSubmissionId
          : expandedSubmissionId as int?,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }
}
