import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/teacher_exams/data/data_source/teacher_exams_ds.dart';
import 'package:close_gap/features/teacher_exams/data/model/request/add_exam_question_request_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/request/create_exam_request_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/academic_course_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/add_exam_question_response_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/create_exam_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TeacherExamsDs)
class TeacherExamsDsImp implements TeacherExamsDs {
  final ApiServices _apiServices;

  TeacherExamsDsImp(this._apiServices);

  @override
  Future<List<TeacherAcademicCourseDto>> getAcademicCourses() {
    return _apiServices.getTeacherAcademicCourses();
  }

  @override
  Future<CreateExamResponseDto> createExam(CreateExamRequestDto requestDto) {
    return _apiServices.createAcademicExam(requestDto);
  }

  @override
  Future<AddExamQuestionResponseDto> addQuestion(
    int examId,
    AddExamQuestionRequestDto requestDto,
  ) {
    return _apiServices.addAcademicExamQuestion(examId, requestDto);
  }

  @override
  Future<CreateExamResponseDto> publishExam(int examId) {
    return _apiServices.publishAcademicExam(examId);
  }
}
