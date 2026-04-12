import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_answer_request.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_finish_request.dart';
import 'package:close_gap/features/assessment/data/model/request/start_exam_request.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_answer_entity%20.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_finish_entity.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_question_entity.dart';
import 'package:close_gap/features/assessment/domain/entities/start_exam_entity.dart';
import 'package:close_gap/features/assessment/domain/repo/assessment_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AssessmentUseCase {
  final AssessmentRepo _assessmentRepo;

  AssessmentUseCase(this._assessmentRepo);

  Future<ApiResult<ExamAnswerEntity>> submitAnswer(ExamAnswerRequest request) {
    return _assessmentRepo.getExamAnswers(request);
  }

  Future<ApiResult<ExamFinishEntity>> finishExam(ExamFinishRequest request) {
    return _assessmentRepo.getExamFinish(request);
  }

  Future<ApiResult<ExamQuestionsEntity>> getExamQuestions({
    required String track,
    required String level,
    required int page,
    required int perPage,
  }) {
    return _assessmentRepo.getExamQuestions(
      track: track,
      level: level,
      page: page,
      perPage: perPage,
    );
  }
  Future<ApiResult<StartExamEntity>> getStartExam(StartExamRequest request) {
    return _assessmentRepo.getStartExam(request);
  }
}
