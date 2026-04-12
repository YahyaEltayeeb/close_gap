import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_answer_request.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_finish_request.dart';
import 'package:close_gap/features/assessment/data/model/request/start_exam_request.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_answer_entity%20.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_finish_entity.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_question_entity.dart';
import 'package:close_gap/features/assessment/domain/entities/start_exam_entity.dart';

abstract class AssessmentRepo {
  Future<ApiResult<ExamAnswerEntity>> getExamAnswers(
    ExamAnswerRequest examAnswerRequest,
  );
  Future<ApiResult<ExamFinishEntity>> getExamFinish(ExamFinishRequest examFinishRequest);
  Future<ApiResult<StartExamEntity>> getStartExam(StartExamRequest startexamRequest);
  Future<ApiResult<ExamQuestionsEntity>> getExamQuestions({
    required String track,
    required String level,
    required int page,
    required int perPage,
  });
}
