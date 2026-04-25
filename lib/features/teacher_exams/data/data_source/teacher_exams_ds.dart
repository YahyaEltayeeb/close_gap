import 'package:close_gap/features/teacher_exams/data/model/request/add_exam_question_request_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/request/create_exam_request_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/academic_course_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/add_exam_question_response_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/create_exam_response_dto.dart';

abstract class TeacherExamsDs {
  Future<List<TeacherAcademicCourseDto>> getAcademicCourses();

  Future<CreateExamResponseDto> createExam(CreateExamRequestDto requestDto);

  Future<AddExamQuestionResponseDto> addQuestion(
    int examId,
    AddExamQuestionRequestDto requestDto,
  );

  Future<CreateExamResponseDto> publishExam(int examId);
}
