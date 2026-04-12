import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/assessment/data/data_source/assessment_ds.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_answer_request.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_finish_request.dart';
import 'package:close_gap/features/assessment/data/model/request/start_exam_request.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_answer_response.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_finish_response.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_questions_response.dart';
import 'package:close_gap/features/assessment/data/model/response/start_exam_response.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_answer_entity%20.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_finish_entity.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_question_entity.dart';
import 'package:close_gap/features/assessment/domain/entities/start_exam_entity.dart';
import 'package:close_gap/features/assessment/domain/repo/assessment_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AssessmentRepo)
class AssessmentRepoImp implements AssessmentRepo {
  final AssessmentDs _assessmentDs;
  AssessmentRepoImp(this._assessmentDs);
  @override
  Future<ApiResult<ExamAnswerEntity>> getExamAnswers(
    ExamAnswerRequest examAnswerRequest,
  ) async {
    return await safeApiCall(() async {
      final result = await _assessmentDs.getExamAnswers(examAnswerRequest);
      return result.toEntity();
    });
  }

  @override
  Future<ApiResult<ExamFinishEntity>> getExamFinish(
    ExamFinishRequest examFinishRequest,
  ) async {
    return await safeApiCall(() async {
      final result = await _assessmentDs.getExamFinish(examFinishRequest);
      return result.toEntity();
    });
  }

  @override
  Future<ApiResult<ExamQuestionsEntity>> getExamQuestions({
    required String track,
    required String level,
    required int page,
    required int perPage,
  }) async {
    return await safeApiCall(() async {
      final result = await _assessmentDs.getExamQuestions(
        level: level,
        page: page,
        perPage: perPage,
      );
      return result.toEntity();
    });
  }

  @override
  Future<ApiResult<StartExamEntity>> getStartExam(
    StartExamRequest startexamRequest,
  ) async {
    return await safeApiCall(() async {
      final result = await _assessmentDs.getStartExam(startexamRequest);
      return result.toEntity();
    });
  }
}
