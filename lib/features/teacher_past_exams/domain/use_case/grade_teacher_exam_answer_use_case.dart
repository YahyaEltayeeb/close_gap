import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_past_exams/domain/repo/teacher_past_exams_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GradeTeacherExamAnswerUseCase {
  final TeacherPastExamsRepo _teacherPastExamsRepo;

  GradeTeacherExamAnswerUseCase(this._teacherPastExamsRepo);

  Future<ApiResult<String>> call(
    int answerId, {
    double? score,
    String? feedback,
  }) {
    return _teacherPastExamsRepo.gradeSubmissionAnswer(
      answerId,
      score: score,
      feedback: feedback,
    );
  }
}
