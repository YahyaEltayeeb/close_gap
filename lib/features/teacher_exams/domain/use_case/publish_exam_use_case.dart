import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/repo/teacher_exams_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class PublishExamUseCase {
  final TeacherExamsRepo _teacherExamsRepo;

  PublishExamUseCase(this._teacherExamsRepo);

  Future<ApiResult<AcademicExamEntity>> call(int examId) {
    return _teacherExamsRepo.publishExam(examId);
  }
}
