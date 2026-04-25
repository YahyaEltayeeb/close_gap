import 'package:close_gap/features/academic_course/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/academic_exam_results_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/explanation_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/publish_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/start_exam_academic_entity.dart';
import 'package:close_gap/features/academic_course/domain/entities/submission_exam_entity.dart';
import 'package:equatable/equatable.dart';

sealed class AcademicCourseStates extends Equatable {
  const AcademicCourseStates();

  @override
  List<Object?> get props => [];
}

// =====================
// Initial State
// =====================
class AcademicCourseInitial extends AcademicCourseStates {
  const AcademicCourseInitial();
}

// =====================
// Get Academic Courses
// =====================
class GetAcademicCourseLoading extends AcademicCourseStates {
  const GetAcademicCourseLoading();
}

class GetAcademicCourseSuccess extends AcademicCourseStates {
  final List<AcademicCourseEntity> courses;

  const GetAcademicCourseSuccess({required this.courses});

  GetAcademicCourseSuccess copyWith({List<AcademicCourseEntity>? courses}) {
    return GetAcademicCourseSuccess(courses: courses ?? this.courses);
  }

  @override
  List<Object?> get props => [courses];
}

class GetAcademicCourseFailure extends AcademicCourseStates {
  final String message;

  const GetAcademicCourseFailure({required this.message});

  GetAcademicCourseFailure copyWith({String? message}) {
    return GetAcademicCourseFailure(message: message ?? this.message);
  }

  @override
  List<Object?> get props => [message];
}

// =====================
// Course Explanations
// =====================
class AcademicCourseExplanationsLoading extends AcademicCourseStates {
  const AcademicCourseExplanationsLoading();
}

class AcademicCourseExplanationsSuccess extends AcademicCourseStates {
  final List<ExplanationEntity> explanations;

  const AcademicCourseExplanationsSuccess({required this.explanations});

  AcademicCourseExplanationsSuccess copyWith(
      {List<ExplanationEntity>? explanations}) {
    return AcademicCourseExplanationsSuccess(
        explanations: explanations ?? this.explanations);
  }

  @override
  List<Object?> get props => [explanations];
}

class AcademicCourseExplanationsFailure extends AcademicCourseStates {
  final String message;

  const AcademicCourseExplanationsFailure({required this.message});

  AcademicCourseExplanationsFailure copyWith({String? message}) {
    return AcademicCourseExplanationsFailure(message: message ?? this.message);
  }

  @override
  List<Object?> get props => [message];
}

// =====================
// Published Exams
// =====================
class AcademicCoursePublishedExamsLoading extends AcademicCourseStates {
  const AcademicCoursePublishedExamsLoading();
}

class AcademicCoursePublishedExamsSuccess extends AcademicCourseStates {
  final List<PublishExamAcademicEntity> exams;

  const AcademicCoursePublishedExamsSuccess({required this.exams});

  AcademicCoursePublishedExamsSuccess copyWith(
      {List<PublishExamAcademicEntity>? exams}) {
    return AcademicCoursePublishedExamsSuccess(exams: exams ?? this.exams);
  }

  @override
  List<Object?> get props => [exams];
}

class AcademicCoursePublishedExamsFailure extends AcademicCourseStates {
  final String message;

  const AcademicCoursePublishedExamsFailure({required this.message});

  AcademicCoursePublishedExamsFailure copyWith({String? message}) {
    return AcademicCoursePublishedExamsFailure(
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [message];
}

// =====================
// Start Exam
// =====================
class StartAcademicExamLoading extends AcademicCourseStates {
  const StartAcademicExamLoading();
}

class StartAcademicExamSuccess extends AcademicCourseStates {
  final StartExamAcademicEntity examData;

  const StartAcademicExamSuccess({required this.examData});

  StartAcademicExamSuccess copyWith({StartExamAcademicEntity? examData}) {
    return StartAcademicExamSuccess(examData: examData ?? this.examData);
  }

  @override
  List<Object?> get props => [examData];
}

class StartAcademicExamFailure extends AcademicCourseStates {
  final String message;

  const StartAcademicExamFailure({required this.message});

  StartAcademicExamFailure copyWith({String? message}) {
    return StartAcademicExamFailure(message: message ?? this.message);
  }

  @override
  List<Object?> get props => [message];
}

// =====================
// Submit Exam
// =====================
class SubmitAcademicExamLoading extends AcademicCourseStates {
  const SubmitAcademicExamLoading();
}

class SubmitAcademicExamSuccess extends AcademicCourseStates {
  final SubmissionExamEntity submissionResult;

  const SubmitAcademicExamSuccess({required this.submissionResult});

  SubmitAcademicExamSuccess copyWith(
      {SubmissionExamEntity? submissionResult}) {
    return SubmitAcademicExamSuccess(
        submissionResult: submissionResult ?? this.submissionResult);
  }

  @override
  List<Object?> get props => [submissionResult];
}

class SubmitAcademicExamFailure extends AcademicCourseStates {
  final String message;

  const SubmitAcademicExamFailure({required this.message});

  SubmitAcademicExamFailure copyWith({String? message}) {
    return SubmitAcademicExamFailure(message: message ?? this.message);
  }

  @override
  List<Object?> get props => [message];
}
class GetAcademicExamResultLoading extends AcademicCourseStates {
  const GetAcademicExamResultLoading();
}
class GetAcademicExamResultSuccess extends AcademicCourseStates {
  final List<AcademicExamResultsEntity> examResults;

  const GetAcademicExamResultSuccess({required this.examResults});

  GetAcademicExamResultSuccess copyWith(
      {List<AcademicExamResultsEntity>? examResults}) {
    return GetAcademicExamResultSuccess(
        examResults: examResults ?? this.examResults);
  }

  @override
  List<Object?> get props => [examResults];
}
class GetAcademicExamResultFailure extends AcademicCourseStates {
  final String message;

  const GetAcademicExamResultFailure({required this.message});

  GetAcademicExamResultFailure copyWith({String? message}) {
    return GetAcademicExamResultFailure(message: message ?? this.message);
  }

  @override
  List<Object?> get props => [message];
}