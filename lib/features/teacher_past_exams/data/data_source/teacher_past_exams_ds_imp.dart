import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/teacher_past_exams/data/data_source/teacher_past_exams_ds.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/request/grade_submission_answer_request_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_question_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_list_item_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_results_response_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_submissions_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TeacherPastExamsDs)
class TeacherPastExamsDsImp implements TeacherPastExamsDs {
  final ApiServices _apiServices;

  TeacherPastExamsDsImp(this._apiServices);

  @override
  Future<List<TeacherExamListItemDto>> getMyExams() {
    return _apiServices.getMyAcademicExams();
  }

  @override
  Future<List<TeacherExamQuestionDto>> getExamQuestions(int examId) {
    return _apiServices.getAcademicExamQuestions(examId);
  }

  @override
  Future<TeacherExamResultsResponseDto> getExamResults(int examId) {
    return _apiServices.getAcademicExamResults(examId);
  }

  @override
  Future<TeacherExamSubmissionsResponseDto> getExamSubmissions(
    int examId, {
    int page = 1,
    int perPage = 100,
  }) {
    return _apiServices.getAcademicExamSubmissions(examId, page, perPage);
  }

  @override
  Future<void> gradeSubmissionAnswer(
    int answerId,
    GradeSubmissionAnswerRequestDto requestDto,
  ) {
    return _apiServices.gradeAcademicExamAnswer(answerId, requestDto);
  }
}
