import 'package:close_gap/features/assessment/data/model/request/exam_answer_request.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_finish_request.dart';
import 'package:close_gap/features/assessment/data/model/request/start_exam_request.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_answer_response.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_finish_response.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_questions_response.dart';
import 'package:close_gap/features/assessment/data/model/response/start_exam_response.dart';

abstract class AssessmentDs {
  Future<ExamAnswerResponse> getExamAnswers(
    ExamAnswerRequest examAnswerRequest,
  );
  Future<ExamFinishResponse> getExamFinish(ExamFinishRequest examFinishRequest);
  Future<StartexamResponse> getStartExam(StartExamRequest startexamRequest);
  Future<ExamquestionsResponse> getExamQuestions({
    required String track,
    required String level,
    required int page,
    required int perPage,
  });
}
