import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/academic_course/data/models/request/submission_exam_request.dart';
import 'package:close_gap/features/academic_course/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/academic_exam_results_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/explanation_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/publish_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/start_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/submission_exam_entity.dart';
import 'package:close_gap/features/academic_course/domain/repo/academic_course_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AcademicCourseUseCase {
  final AcademicCourseRepo _academicCourseRepo;

  AcademicCourseUseCase(this._academicCourseRepo);
  Future<ApiResult<List<AcademicCourseEntity>>> getAcademicCourses(
    int semester,
  ) {
    return _academicCourseRepo.getAcademicCourses(semester);
  }

  Future<ApiResult<List<ExplanationEntity>>> getAcademicCourseExplanations(
    int courseId,
  ) {
    return _academicCourseRepo.getAcademicCourseExplanations(courseId);
  }

  Future<ApiResult<List<PublishExamAcademicEntity>>>
  getAcademicCoursePublishedExams() {
    return _academicCourseRepo.getAcademicCoursePublishedExams();
  }

  Future<ApiResult<StartExamAcademicEntity>> startAcademicExam(int examId) {
    return _academicCourseRepo.startAcademicExam(examId);
  }

  Future<ApiResult<SubmissionExamEntity>> submitAcademicExam(
    int examId,
    SubmissionExamRequest submissionExamRequest,
  ) {
    return _academicCourseRepo.submitAcademicExam(
      examId,
      submissionExamRequest,
    );
  }

  Future<ApiResult<List<AcademicExamResultsEntity>>> getAcademicExamResult() {
    return _academicCourseRepo.getAcademicExamResult();
  }
}
