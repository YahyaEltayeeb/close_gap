import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_question_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_list_item_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_results_overview_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_submission_entity.dart';

abstract class TeacherPastExamsRepo {
  Future<ApiResult<List<TeacherExamListItemEntity>>> getMyExams();

  Future<ApiResult<List<TeacherExamQuestionEntity>>> getExamQuestions(
    int examId,
  );

  Future<ApiResult<TeacherExamResultsOverviewEntity>> getExamResults(
    int examId,
  );

  Future<ApiResult<List<TeacherExamSubmissionEntity>>> getExamSubmissions(
    int examId,
  );

  Future<ApiResult<String>> gradeSubmissionAnswer(
    int answerId, {
    double? score,
    String? feedback,
  });
}
