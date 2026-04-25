import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_question_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_results_overview_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_submission_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/use_case/get_teacher_exam_questions_use_case.dart';
import 'package:close_gap/features/teacher_past_exams/domain/use_case/get_teacher_exam_results_use_case.dart';
import 'package:close_gap/features/teacher_past_exams/domain/use_case/get_teacher_exam_submissions_use_case.dart';
import 'package:close_gap/features/teacher_past_exams/domain/use_case/grade_teacher_exam_answer_use_case.dart';
import 'package:close_gap/features/teacher_past_exams/presentation/manager/teacher_exam_results_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TeacherExamResultsCubit extends Cubit<TeacherExamResultsState> {
  final GetTeacherExamResultsUseCase _getTeacherExamResultsUseCase;
  final GetTeacherExamQuestionsUseCase _getTeacherExamQuestionsUseCase;
  final GetTeacherExamSubmissionsUseCase _getTeacherExamSubmissionsUseCase;
  final GradeTeacherExamAnswerUseCase _gradeTeacherExamAnswerUseCase;

  TeacherExamResultsCubit(
    this._getTeacherExamResultsUseCase,
    this._getTeacherExamQuestionsUseCase,
    this._getTeacherExamSubmissionsUseCase,
    this._gradeTeacherExamAnswerUseCase,
  ) : super(const TeacherExamResultsState());

  Future<void> loadExamData(int examId) async {
    emit(
      state.copyWith(isLoading: true, errorMessage: null, successMessage: null),
    );

    final resultsResponse = await _getTeacherExamResultsUseCase(examId);
    final questionsResponse = await _getTeacherExamQuestionsUseCase(examId);
    final submissionsResponse = await _getTeacherExamSubmissionsUseCase(examId);

    if (resultsResponse is ApiErrorResult) {
      final failure =
          (resultsResponse as ApiErrorResult<TeacherExamResultsOverviewEntity>)
              .failure;
      emit(state.copyWith(isLoading: false, errorMessage: failure));
      return;
    }

    if (questionsResponse is ApiErrorResult) {
      final failure =
          (questionsResponse as ApiErrorResult<List<TeacherExamQuestionEntity>>)
              .failure;
      emit(state.copyWith(isLoading: false, errorMessage: failure));
      return;
    }

    if (submissionsResponse is ApiErrorResult) {
      final failure =
          (submissionsResponse
                  as ApiErrorResult<List<TeacherExamSubmissionEntity>>)
              .failure;
      emit(state.copyWith(isLoading: false, errorMessage: failure));
      return;
    }

    final overview =
        (resultsResponse as ApiSuccessResult<TeacherExamResultsOverviewEntity>)
            .data;
    final questions =
        (questionsResponse as ApiSuccessResult<List<TeacherExamQuestionEntity>>)
            .data;
    final submissions =
        (submissionsResponse
                as ApiSuccessResult<List<TeacherExamSubmissionEntity>>)
            .data;

    emit(
      state.copyWith(
        isLoading: false,
        overview: overview,
        questions: questions,
        submissions: submissions,
      ),
    );
  }

  void toggleSubmission(int submissionId) {
    final isSameSubmission = state.expandedSubmissionId == submissionId;
    emit(
      state.copyWith(
        expandedSubmissionId: isSameSubmission ? null : submissionId,
        currentQuestionIndex: 0,
        successMessage: null,
      ),
    );
  }

  void nextQuestion() {
    if (state.questions.isEmpty) return;
    final nextIndex = state.currentQuestionIndex + 1;
    if (nextIndex >= state.questions.length) return;
    emit(state.copyWith(currentQuestionIndex: nextIndex));
  }

  void previousQuestion() {
    if (state.currentQuestionIndex == 0) return;
    emit(state.copyWith(currentQuestionIndex: state.currentQuestionIndex - 1));
  }

  Future<void> submitGrades(
    int examId,
    List<({int answerId, double? score, String? feedback})> grades,
  ) async {
    if (grades.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'No answers available to grade for this submission',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmittingGrades: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    for (final grade in grades) {
      final result = await _gradeTeacherExamAnswerUseCase(
        grade.answerId,
        score: grade.score,
        feedback: grade.feedback,
      );

      if (result case ApiErrorResult(failure: final failure)) {
        emit(state.copyWith(isSubmittingGrades: false, errorMessage: failure));
        return;
      }
    }

    emit(
      state.copyWith(
        isSubmittingGrades: false,
        successMessage: 'Submission graded successfully',
        expandedSubmissionId: null,
        currentQuestionIndex: 0,
      ),
    );
    await loadExamData(examId);
  }

  void clearFeedback() {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }
}
