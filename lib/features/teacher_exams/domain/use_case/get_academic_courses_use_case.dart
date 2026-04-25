import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/repo/teacher_exams_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAcademicCoursesUseCase {
  final TeacherExamsRepo _teacherExamsRepo;

  GetAcademicCoursesUseCase(this._teacherExamsRepo);

  Future<ApiResult<List<AcademicCourseEntity>>> call() {
    return _teacherExamsRepo.getAcademicCourses();
  }
}
