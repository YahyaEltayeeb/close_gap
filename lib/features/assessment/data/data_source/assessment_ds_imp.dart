import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/assessment/data/data_source/assessment_ds.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_answer_request.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_finish_request.dart';
import 'package:close_gap/features/assessment/data/model/request/start_exam_request.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_answer_response.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_finish_response.dart';
import 'package:close_gap/features/assessment/data/model/response/exam_questions_response.dart';
import 'package:close_gap/features/assessment/data/model/response/start_exam_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AssessmentDs)
class AssessmentDsImp implements AssessmentDs {
  final ApiServices _apiServices;

  AssessmentDsImp(this._apiServices);
  @override
  Future<ExamAnswerResponse> getExamAnswers(
    ExamAnswerRequest examAnswerRequest,
  ) {
    return _apiServices.answerExam(examAnswerRequest);
  }

  @override
  Future<ExamFinishResponse> getExamFinish(
    ExamFinishRequest examFinishRequest,
  ) {
    return _apiServices.finishExam(examFinishRequest);
  }

  @override
  Future<ExamquestionsResponse> getExamQuestions({
    required String level,
    required int page,
    required int perPage,
  }) {
    return _apiServices.getExamQuestions( 
     
    );
  }

  @override
  Future<StartexamResponse> getStartExam(StartExamRequest startexamRequest) {
    return _apiServices.startExam(startexamRequest);
  }
}
