import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/academic_course/data/data_source/academic_course_ds.dart';
import 'package:close_gap/features/academic_course/data/models/request/submission_exam_request.dart';
import 'package:close_gap/features/academic_course/data/models/response/academic_course_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/academic_exam_results_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/explanation_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/publish_exam_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/start_exam_dto.dart';
import 'package:close_gap/features/academic_course/data/models/response/submission_exam_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AcademicCourseDataSource)
class AcademicCourseDsImp implements AcademicCourseDataSource {
  final ApiServices _apiServices;
  AcademicCourseDsImp(this._apiServices);
  @override
  Future<List<AcademicCourseDto>> getAcademicCourses(int semester) {
    return _apiServices.getAcademicCoursesBySemester(semester);
  }

  @override
  Future<List<ExplanationDto>> getAcademicCourseExplanations(int courseId) {
    return _apiServices.getAcademicCourseExplanation(courseId);
  }

  @override
  Future<List<PublishExamDto>> getAcademicCoursePublishedExams() {
    return _apiServices.getAcademicPublishedExam();
  }

  @override
  Future<StartExamDto> startAcademicExam(int examId) {
    return _apiServices.startAcademicExam(examId);
  }

  @override
  Future<SubmissionExamResponseDto> submitAcademicExam(
    int examId,
    SubmissionExamRequest submissionExamRequest,
  ) {
    return _apiServices.submitAcademicExam(examId, submissionExamRequest);
  }

  @override
  Future<List<AcademicExamResultsDto>> getAcademicExamResult() {
    return _apiServices.getAcademicExamResult();
  }
  
}
