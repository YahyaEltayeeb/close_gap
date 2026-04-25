import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_submission_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/repo/teacher_past_exams_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTeacherExamSubmissionsUseCase {
  final TeacherPastExamsRepo _teacherPastExamsRepo;

  GetTeacherExamSubmissionsUseCase(this._teacherPastExamsRepo);

  Future<ApiResult<List<TeacherExamSubmissionEntity>>> call(int examId) {
    return _teacherPastExamsRepo.getExamSubmissions(examId);
  }
}
