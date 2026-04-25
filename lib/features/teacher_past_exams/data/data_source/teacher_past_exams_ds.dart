import 'package:close_gap/features/teacher_past_exams/data/model/request/grade_submission_answer_request_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_question_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_list_item_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_results_response_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_submissions_response_dto.dart';

abstract class TeacherPastExamsDs {
  Future<List<TeacherExamListItemDto>> getMyExams();

  Future<List<TeacherExamQuestionDto>> getExamQuestions(int examId);

  Future<TeacherExamResultsResponseDto> getExamResults(int examId);

  Future<TeacherExamSubmissionsResponseDto> getExamSubmissions(
    int examId, {
    int page = 1,
    int perPage = 100,
  });

  Future<void> gradeSubmissionAnswer(
    int answerId,
    GradeSubmissionAnswerRequestDto requestDto,
  );
}
