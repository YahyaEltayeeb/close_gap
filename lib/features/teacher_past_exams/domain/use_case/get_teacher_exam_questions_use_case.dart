import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_question_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/repo/teacher_past_exams_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTeacherExamQuestionsUseCase {
  final TeacherPastExamsRepo _teacherPastExamsRepo;

  GetTeacherExamQuestionsUseCase(this._teacherPastExamsRepo);

  Future<ApiResult<List<TeacherExamQuestionEntity>>> call(int examId) {
    return _teacherPastExamsRepo.getExamQuestions(examId);
  }
}
