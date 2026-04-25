import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/academic_course/data/models/request/submission_exam_request.dart';
import 'package:close_gap/features/academic_course/domain/use_case/academic_course_use_case.dart';
import 'package:close_gap/features/academic_course/presentation/manager/academic_course_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@Injectable()
class AcademicCourseCubit extends Cubit<AcademicCourseStates> {
  final AcademicCourseUseCase _academicCourseUseCase;

  AcademicCourseCubit(this._academicCourseUseCase)
      : super(const AcademicCourseInitial());

  // =====================
  // Get Academic Courses
  // =====================
  Future<void> getAcademicCourses(int semester) async {
    emit(const GetAcademicCourseLoading());

    final ApiResult result =
        await _academicCourseUseCase.getAcademicCourses(semester);

    switch (result) {
      case ApiSuccessResult():
        emit(GetAcademicCourseSuccess(courses: result.data));
      case ApiErrorResult():
        emit(GetAcademicCourseFailure(message: result.failure));
    }
  }

  // =====================
  // Course Explanations
  // =====================
  Future<void> getAcademicCourseExplanations(int courseId) async {
    emit(const AcademicCourseExplanationsLoading());

    final ApiResult result =
        await _academicCourseUseCase.getAcademicCourseExplanations(courseId);

    switch (result) {
      case ApiSuccessResult():
        emit(AcademicCourseExplanationsSuccess(explanations: result.data));
      case ApiErrorResult():
        emit(AcademicCourseExplanationsFailure(message: result.failure));
    }
  }

  // =====================
  // Published Exams
  // =====================
  Future<void> getAcademicCoursePublishedExams() async {
    emit(const AcademicCoursePublishedExamsLoading());

    final ApiResult result =
        await _academicCourseUseCase.getAcademicCoursePublishedExams();

    switch (result) {
      case ApiSuccessResult():
        emit(AcademicCoursePublishedExamsSuccess(exams: result.data));
      case ApiErrorResult():
        emit(AcademicCoursePublishedExamsFailure(message: result.failure));
    }
  }

  // =====================
  // Start Exam
  // =====================
  Future<void> startAcademicExam(int examId) async {
    emit(const StartAcademicExamLoading());

    final ApiResult result =
        await _academicCourseUseCase.startAcademicExam(examId);

    switch (result) {
      case ApiSuccessResult():
        emit(StartAcademicExamSuccess(examData: result.data));
      case ApiErrorResult():
        emit(StartAcademicExamFailure(message: result.failure));
    }
  }

  // =====================
  // Submit Exam
  // =====================
  Future<void> submitAcademicExam(
    int examId,
    SubmissionExamRequest submissionExamRequest,
  ) async {
    emit(const SubmitAcademicExamLoading());

    final ApiResult result = await _academicCourseUseCase.submitAcademicExam(
      examId,
      submissionExamRequest,
    );

    switch (result) {
      case ApiSuccessResult():
        emit(SubmitAcademicExamSuccess(submissionResult: result.data));
      case ApiErrorResult():
        emit(SubmitAcademicExamFailure(message: result.failure));
    }
  }
  Future<void> getAcademicExamResult() async {
    emit(const GetAcademicExamResultLoading());

    final ApiResult result = await _academicCourseUseCase.getAcademicExamResult();

    switch (result) {
      case ApiSuccessResult():
        emit(GetAcademicExamResultSuccess(examResults: result.data));
      case ApiErrorResult():
        emit(GetAcademicExamResultFailure(message: result.failure));
    }
  }
}