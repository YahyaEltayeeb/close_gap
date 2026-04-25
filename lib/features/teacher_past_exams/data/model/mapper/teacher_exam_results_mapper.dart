import 'package:close_gap/features/teacher_past_exams/data/model/mapper/teacher_past_exams_mapper.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_question_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_results_response_dto.dart';
import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_submissions_response_dto.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_question_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_results_overview_entity.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_submission_entity.dart';

extension TeacherExamQuestionOptionDtoMapper on TeacherExamQuestionOptionDto {
  TeacherExamQuestionOptionEntity toEntity() {
    return TeacherExamQuestionOptionEntity(
      id: id ?? 0,
      order: order ?? 0,
      questionId: questionId ?? 0,
      text: (text ?? '').trim(),
    );
  }
}

extension TeacherExamQuestionDtoMapper on TeacherExamQuestionDto {
  TeacherExamQuestionEntity toEntity() {
    return TeacherExamQuestionEntity(
      correctOptionId: correctOptionId ?? 0,
      examId: examId ?? 0,
      id: id ?? 0,
      marks: marks ?? 0,
      options: (options ?? []).map((option) => option.toEntity()).toList(),
      order: order ?? 0,
      questionType: (questionType ?? '').trim(),
      text: (text ?? '').trim(),
    );
  }
}

extension TeacherExamResultStudentDtoMapper on TeacherExamResultStudentDto {
  TeacherExamResultStudentEntity toEntity() {
    return TeacherExamResultStudentEntity(
      finalScore: finalScore,
      passed: passed,
      status: (status ?? '').trim(),
      studentId: studentId ?? 0,
      studentName: (studentName ?? '').trim(),
      submissionId: submissionId ?? 0,
      submittedAt: submittedAt ?? '',
    );
  }
}

extension TeacherExamResultsResponseDtoMapper on TeacherExamResultsResponseDto {
  TeacherExamResultsOverviewEntity toEntity() {
    return TeacherExamResultsOverviewEntity(
      exam: exam.toEntity(),
      passedCount: passedCount ?? 0,
      results: (results ?? []).map((result) => result.toEntity()).toList(),
      totalSubmissions: totalSubmissions ?? 0,
    );
  }
}

extension TeacherExamSubmissionAnswerDtoMapper
    on TeacherExamSubmissionAnswerDto {
  TeacherExamSubmissionAnswerEntity toEntity() {
    return TeacherExamSubmissionAnswerEntity(
      answerId: answerId ?? 0,
      questionId: questionId,
      questionText: (questionText ?? '').trim(),
      chosenOptionText: (chosenOptionText ?? '').trim(),
      openAnswerText: (openAnswerText ?? '').trim(),
      isCorrect: isCorrect,
      score: score,
      feedback: (feedback ?? '').trim(),
    );
  }
}

extension TeacherExamSubmissionDtoMapper on TeacherExamSubmissionDto {
  TeacherExamSubmissionEntity toEntity() {
    return TeacherExamSubmissionEntity(
      submissionId: submissionId ?? 0,
      studentName: (studentName ?? '').trim(),
      status: (status ?? '').trim(),
      answers: (answers ?? []).map((answer) => answer.toEntity()).toList(),
    );
  }
}
