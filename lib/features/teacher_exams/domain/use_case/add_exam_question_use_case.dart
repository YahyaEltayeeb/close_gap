import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_question_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/add_exam_question_request_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/repo/teacher_exams_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddExamQuestionUseCase {
  final TeacherExamsRepo _teacherExamsRepo;

  AddExamQuestionUseCase(this._teacherExamsRepo);

  Future<ApiResult<AcademicExamQuestionEntity>> call(
    AddExamQuestionRequestEntity requestEntity,
  ) {
    return _teacherExamsRepo.addQuestion(requestEntity);
  }
}
