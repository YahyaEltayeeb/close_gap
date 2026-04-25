import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_results_overview_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/repo/teacher_past_exams_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTeacherExamResultsUseCase {
  final TeacherPastExamsRepo _teacherPastExamsRepo;

  GetTeacherExamResultsUseCase(this._teacherPastExamsRepo);

  Future<ApiResult<TeacherExamResultsOverviewEntity>> call(int examId) {
    return _teacherPastExamsRepo.getExamResults(examId);
  }
}
