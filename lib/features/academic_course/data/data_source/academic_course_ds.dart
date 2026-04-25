import 'package:close_gap/features/academic_course/data/models/request/submission_exam_request.dart';
import 'package:close_gap/features/academic_course/data/models/response/academic_course_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/academic_exam_results_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/explanation_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/publish_exam_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/start_exam_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/submission_exam_response_dto.dart';

abstract class AcademicCourseDataSource {
  Future<List<AcademicCourseDto>> getAcademicCourses(int semester);
  Future<List<ExplanationDto>> getAcademicCourseExplanations(int courseId);
  Future<List<PublishExamDto>> getAcademicCoursePublishedExams();
  Future<StartExamDto> startAcademicExam(int examId);
  Future<SubmissionExamResponseDto> submitAcademicExam(int examId, SubmissionExamRequest submissionExamRequest);
  Future<List<AcademicExamResultsDto>> getAcademicExamResult();
}