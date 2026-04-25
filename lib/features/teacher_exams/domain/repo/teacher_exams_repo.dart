import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_question_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/add_exam_question_request_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/create_exam_request_entity.dart';

abstract class TeacherExamsRepo {
  Future<ApiResult<List<AcademicCourseEntity>>> getAcademicCourses();

  Future<ApiResult<AcademicExamEntity>> createExam(
    CreateExamRequestEntity requestEntity,
  );

  Future<ApiResult<AcademicExamQuestionEntity>> addQuestion(
    AddExamQuestionRequestEntity requestEntity,
  );

  Future<ApiResult<AcademicExamEntity>> publishExam(int examId);
}
