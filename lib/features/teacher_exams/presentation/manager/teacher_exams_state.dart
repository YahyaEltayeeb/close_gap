import 'package:close_gap/features/teacher_exams/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_question_entity.dart';

class TeacherExamsState {
  static const _sentinel = Object();

  final List<AcademicCourseEntity> courses;
  final bool isCoursesLoading;
  final bool isCreatingExam;
  final bool isAddingQuestion;
  final bool isPublishingExam;
  final String? coursesErrorMessage;
  final String? createExamErrorMessage;
  final String? addQuestionErrorMessage;
  final String? addQuestionSuccessMessage;
  final String? publishExamErrorMessage;
  final String? publishExamSuccessMessage;
  final AcademicExamEntity? createdExam;
  final AcademicExamEntity? publishedExam;
  final List<AcademicExamQuestionEntity> addedQuestions;

  const TeacherExamsState({
    this.courses = const [],
    this.isCoursesLoading = false,
    this.isCreatingExam = false,
    this.isAddingQuestion = false,
    this.isPublishingExam = false,
    this.coursesErrorMessage,
    this.createExamErrorMessage,
    this.addQuestionErrorMessage,
    this.addQuestionSuccessMessage,
    this.publishExamErrorMessage,
    this.publishExamSuccessMessage,
    this.createdExam,
    this.publishedExam,
    this.addedQuestions = const [],
  });

  TeacherExamsState copyWith({
    List<AcademicCourseEntity>? courses,
    bool? isCoursesLoading,
    bool? isCreatingExam,
    bool? isAddingQuestion,
    bool? isPublishingExam,
    Object? coursesErrorMessage = _sentinel,
    Object? createExamErrorMessage = _sentinel,
    Object? addQuestionErrorMessage = _sentinel,
    Object? addQuestionSuccessMessage = _sentinel,
    Object? publishExamErrorMessage = _sentinel,
    Object? publishExamSuccessMessage = _sentinel,
    Object? createdExam = _sentinel,
    Object? publishedExam = _sentinel,
    List<AcademicExamQuestionEntity>? addedQuestions,
  }) {
    return TeacherExamsState(
      courses: courses ?? this.courses,
      isCoursesLoading: isCoursesLoading ?? this.isCoursesLoading,
      isCreatingExam: isCreatingExam ?? this.isCreatingExam,
      isAddingQuestion: isAddingQuestion ?? this.isAddingQuestion,
      isPublishingExam: isPublishingExam ?? this.isPublishingExam,
      coursesErrorMessage: identical(coursesErrorMessage, _sentinel)
          ? this.coursesErrorMessage
          : coursesErrorMessage as String?,
      createExamErrorMessage: identical(createExamErrorMessage, _sentinel)
          ? this.createExamErrorMessage
          : createExamErrorMessage as String?,
      addQuestionErrorMessage: identical(addQuestionErrorMessage, _sentinel)
          ? this.addQuestionErrorMessage
          : addQuestionErrorMessage as String?,
      addQuestionSuccessMessage: identical(addQuestionSuccessMessage, _sentinel)
          ? this.addQuestionSuccessMessage
          : addQuestionSuccessMessage as String?,
      publishExamErrorMessage: identical(publishExamErrorMessage, _sentinel)
          ? this.publishExamErrorMessage
          : publishExamErrorMessage as String?,
      publishExamSuccessMessage: identical(publishExamSuccessMessage, _sentinel)
          ? this.publishExamSuccessMessage
          : publishExamSuccessMessage as String?,
      createdExam: identical(createdExam, _sentinel)
          ? this.createdExam
          : createdExam as AcademicExamEntity?,
      publishedExam: identical(publishedExam, _sentinel)
          ? this.publishedExam
          : publishedExam as AcademicExamEntity?,
      addedQuestions: addedQuestions ?? this.addedQuestions,
    );
  }
}
