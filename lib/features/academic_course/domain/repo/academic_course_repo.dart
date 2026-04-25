import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/academic_course/data/models/request/submission_exam_request.dart';
import 'package:close_gap/features/academic_course/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/academic_exam_results_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/explanation_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/publish_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/start_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/submission_exam_entity.dart';

abstract class AcademicCourseRepo {
  Future<ApiResult<List<AcademicCourseEntity>>> getAcademicCourses(int semester);
  Future<ApiResult<List<ExplanationEntity>>> getAcademicCourseExplanations(
    int courseId,
  );
  Future<ApiResult<List<PublishExamAcademicEntity>>>
  getAcademicCoursePublishedExams();
  Future<ApiResult<StartExamAcademicEntity>> startAcademicExam(int examId);
  Future<ApiResult<SubmissionExamEntity>> submitAcademicExam(
    int examId,
    SubmissionExamRequest submissionExamRequest,
  );
  Future<ApiResult<List<AcademicExamResultsEntity>>> getAcademicExamResult();
}
