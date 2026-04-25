import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_list_item_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/repo/teacher_past_exams_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMyTeacherExamsUseCase {
  final TeacherPastExamsRepo _teacherPastExamsRepo;

  GetMyTeacherExamsUseCase(this._teacherPastExamsRepo);

  Future<ApiResult<List<TeacherExamListItemEntity>>> call() {
    return _teacherPastExamsRepo.getMyExams();
  }
}
