import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/create_exam_request_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/repo/teacher_exams_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateExamUseCase {
  final TeacherExamsRepo _teacherExamsRepo;

  CreateExamUseCase(this._teacherExamsRepo);

  Future<ApiResult<AcademicExamEntity>> call(
    CreateExamRequestEntity requestEntity,
  ) {
    return _teacherExamsRepo.createExam(requestEntity);
  }
}
