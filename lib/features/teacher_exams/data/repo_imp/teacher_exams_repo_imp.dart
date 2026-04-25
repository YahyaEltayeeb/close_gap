import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_exams/data/data_source/teacher_exams_ds.dart';
import 'package:close_gap/features/teacher_exams/data/model/mapper/teacher_exams_mapper.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_question_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/add_exam_question_request_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/create_exam_request_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/repo/teacher_exams_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TeacherExamsRepo)
class TeacherExamsRepoImp implements TeacherExamsRepo {
  final TeacherExamsDs _teacherExamsDs;

  TeacherExamsRepoImp(this._teacherExamsDs);

  @override
  Future<ApiResult<List<AcademicCourseEntity>>> getAcademicCourses() async {
    return safeApiCall(() async {
      final result = await _teacherExamsDs.getAcademicCourses();
      return result.map((course) => course.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<AcademicExamEntity>> createExam(
    CreateExamRequestEntity requestEntity,
  ) async {
    return safeApiCall(() async {
      final result = await _teacherExamsDs.createExam(requestEntity.toDto());
      return result.toEntity();
    });
  }

  @override
  Future<ApiResult<AcademicExamQuestionEntity>> addQuestion(
    AddExamQuestionRequestEntity requestEntity,
  ) async {
    return safeApiCall(() async {
      final result = await _teacherExamsDs.addQuestion(
        requestEntity.examId,
        requestEntity.toDto(),
      );
      return result.toEntity();
    });
  }

  @override
  Future<ApiResult<AcademicExamEntity>> publishExam(int examId) async {
    return safeApiCall(() async {
      final result = await _teacherExamsDs.publishExam(examId);
      return result.toEntity();
    });
  }
}
