import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_past_exams/data/data_source/teacher_past_exams_ds.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/mapper/teacher_exam_results_mapper.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/request/grade_submission_answer_request_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/mapper/teacher_past_exams_mapper.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_question_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_list_item_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_results_overview_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_submission_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/repo/teacher_past_exams_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TeacherPastExamsRepo)
class TeacherPastExamsRepoImp implements TeacherPastExamsRepo {
  final TeacherPastExamsDs _teacherPastExamsDs;

  TeacherPastExamsRepoImp(this._teacherPastExamsDs);

  @override
  Future<ApiResult<List<TeacherExamListItemEntity>>> getMyExams() async {
    return safeApiCall(() async {
      final result = await _teacherPastExamsDs.getMyExams();
      return result.map((exam) => exam.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<TeacherExamQuestionEntity>>> getExamQuestions(
    int examId,
  ) async {
    return safeApiCall(() async {
      final result = await _teacherPastExamsDs.getExamQuestions(examId);
      return result.map((question) => question.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<TeacherExamResultsOverviewEntity>> getExamResults(
    int examId,
  ) async {
    return safeApiCall(() async {
      final result = await _teacherPastExamsDs.getExamResults(examId);
      return result.toEntity();
    });
  }

  @override
  Future<ApiResult<List<TeacherExamSubmissionEntity>>> getExamSubmissions(
    int examId,
  ) async {
    return safeApiCall(() async {
      final result = await _teacherPastExamsDs.getExamSubmissions(examId);
      return (result.submissions ?? [])
          .map((submission) => submission.toEntity())
          .toList();
    });
  }

  @override
  Future<ApiResult<String>> gradeSubmissionAnswer(
    int answerId, {
    double? score,
    String? feedback,
  }) async {
    return safeApiCall(() async {
      await _teacherPastExamsDs.gradeSubmissionAnswer(
        answerId,
        GradeSubmissionAnswerRequestDto(score: score, feedback: feedback),
      );
      return 'Answer graded successfully';
    });
  }
}
