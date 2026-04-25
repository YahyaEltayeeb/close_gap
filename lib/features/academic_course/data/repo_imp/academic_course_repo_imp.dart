import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/academic_course/data/data_source/academic_course_ds.dart';
import 'package:close_gap/features/academic_course/data/models/request/submission_exam_request.dart';
import 'package:close_gap/features/academic_course/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/academic_exam_results_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/explanation_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/publish_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/start_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/submission_exam_entity.dart';
import 'package:close_gap/features/academic_course/domain/repo/academic_course_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AcademicCourseRepo)
class AcademicCourseRepoImp implements AcademicCourseRepo {
  final AcademicCourseDataSource _academicCourseDataSource;

  AcademicCourseRepoImp(this._academicCourseDataSource);

  @override
  Future<ApiResult<List<ExplanationEntity>>> getAcademicCourseExplanations(
    int courseId,
  ) async {
    return await safeApiCall(() async {
      final result = await _academicCourseDataSource
          .getAcademicCourseExplanations(courseId);
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<PublishExamAcademicEntity>>>
  getAcademicCoursePublishedExams() async {
    return await safeApiCall(() async {
      final result = await _academicCourseDataSource
          .getAcademicCoursePublishedExams();
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<AcademicCourseEntity>>> getAcademicCourses(
    int semester,
  ) async {
    return await safeApiCall(() async {
      final result = await _academicCourseDataSource.getAcademicCourses(
        semester,
      );
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<StartExamAcademicEntity>> startAcademicExam(
    int examId,
  ) async {
    return await safeApiCall(() async {
      final result = await _academicCourseDataSource.startAcademicExam(examId);
      return result.toEntity();
    });
  }

  @override
  Future<ApiResult<SubmissionExamEntity>> submitAcademicExam(
    int examId,
    SubmissionExamRequest submissionExamRequest,
  ) async {
    return await safeApiCall(() async {
      final result = await _academicCourseDataSource.submitAcademicExam(
        examId,
        submissionExamRequest,
      );
      return result.toEntity();
    });
  }

  @override
  Future<ApiResult<List<AcademicExamResultsEntity>>> getAcademicExamResult() async{
    return await safeApiCall(() async {
      final result = await _academicCourseDataSource.getAcademicExamResult();
      return result.map((e) => e.toEntity()).toList();
    });
  }
}
