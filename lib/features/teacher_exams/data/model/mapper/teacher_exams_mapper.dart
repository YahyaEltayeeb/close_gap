import 'package:close_gap/features/teacher_exams/data/model/request/add_exam_question_request_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/request/create_exam_request_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/academic_course_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/add_exam_question_response_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/create_exam_response_dto.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_question_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/add_exam_question_request_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/create_exam_request_entity.dart';

extension AcademicCourseDtoMapper on AcademicCourseDto {
  AcademicCourseEntity toEntity() {
    return AcademicCourseEntity(
      id: id ?? 0,
      code: (code ?? '').trim(),
      name: (name ?? '').trim(),
      semester: semester ?? 0,
    );
  }
}

extension CreateExamRequestEntityMapper on CreateExamRequestEntity {
  CreateExamRequestDto toDto() {
    return CreateExamRequestDto(
      academicCourseId: academicCourseId,
      title: title,
      examType: examType,
      durationMinutes: durationMinutes,
      passingScore: passingScore,
      totalMarks: totalMarks,
      startsAt: startsAt,
      endsAt: endsAt,
    );
  }
}

extension CreateExamResponseDtoMapper on CreateExamResponseDto {
  AcademicExamEntity toEntity() {
    return AcademicExamEntity(
      id: exam.id ?? 0,
      academicCourseId: exam.academicCourseId ?? 0,
      academicCourseName: (exam.academicCourseName ?? '').trim(),
      title: (exam.title ?? '').trim(),
      examType: (exam.examType ?? '').trim(),
      durationMinutes: exam.durationMinutes ?? 0,
      passingScore: exam.passingScore ?? 0,
      totalMarks: exam.totalMarks ?? 0,
      startsAt: exam.startsAt ?? '',
      endsAt: exam.endsAt ?? '',
      isPublished: exam.isPublished ?? false,
      questionCount: exam.questionCount ?? 0,
    );
  }
}

extension AddExamQuestionRequestEntityMapper on AddExamQuestionRequestEntity {
  AddExamQuestionRequestDto toDto() {
    return AddExamQuestionRequestDto(
      text: text,
      questionType: 'mcq',
      marks: marks,
      options: options
          .map(
            (option) => AddExamQuestionOptionRequestDto(
              text: option.text,
              isCorrect: option.isCorrect,
            ),
          )
          .toList(),
    );
  }
}

extension AddExamQuestionResponseDtoMapper on AddExamQuestionResponseDto {
  AcademicExamQuestionEntity toEntity() {
    return AcademicExamQuestionEntity(
      id: question.id ?? 0,
      examId: question.examId ?? 0,
      text: (question.text ?? '').trim(),
      questionType: (question.questionType ?? '').trim(),
      marks: question.marks ?? 0,
      order: question.order ?? 0,
      correctOptionId: question.correctOptionId,
      options: question.options
          .map(
            (option) => AcademicExamQuestionOptionEntity(
              id: option.id ?? 0,
              questionId: option.questionId ?? 0,
              order: option.order ?? 0,
              text: (option.text ?? '').trim(),
            ),
          )
          .toList(),
    );
  }
}
