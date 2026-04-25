import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/add_exam_question_request_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/create_exam_request_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/use_case/add_exam_question_use_case.dart';
import 'package:close_gap/features/teacher_exams/domain/use_case/create_exam_use_case.dart';
import 'package:close_gap/features/teacher_exams/domain/use_case/get_academic_courses_use_case.dart';
import 'package:close_gap/features/teacher_exams/domain/use_case/publish_exam_use_case.dart';
import 'package:close_gap/features/teacher_exams/presentation/manager/teacher_exams_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TeacherExamsCubit extends Cubit<TeacherExamsState> {
  final GetAcademicCoursesUseCase _getAcademicCoursesUseCase;
  final CreateExamUseCase _createExamUseCase;
  final AddExamQuestionUseCase _addExamQuestionUseCase;
  final PublishExamUseCase _publishExamUseCase;

  TeacherExamsCubit(
    this._getAcademicCoursesUseCase,
    this._createExamUseCase,
    this._addExamQuestionUseCase,
    this._publishExamUseCase,
  ) : super(const TeacherExamsState());

  Future<void> loadAcademicCourses() async {
    emit(state.copyWith(isCoursesLoading: true, coursesErrorMessage: null));

    final result = await _getAcademicCoursesUseCase();
    switch (result) {
      case ApiSuccessResult(data: final data):
        emit(
          state.copyWith(
            isCoursesLoading: false,
            courses: data,
            coursesErrorMessage: null,
          ),
        );
      case ApiErrorResult(failure: final failure):
        emit(
          state.copyWith(isCoursesLoading: false, coursesErrorMessage: failure),
        );
    }
  }

  Future<void> createExam(CreateExamRequestEntity requestEntity) async {
    emit(
      state.copyWith(
        isCreatingExam: true,
        createExamErrorMessage: null,
        createdExam: null,
      ),
    );

    final result = await _createExamUseCase(requestEntity);
    switch (result) {
      case ApiSuccessResult(data: final data):
        emit(
          state.copyWith(
            isCreatingExam: false,
            createExamErrorMessage: null,
            createdExam: data,
          ),
        );
      case ApiErrorResult(failure: final failure):
        emit(
          state.copyWith(
            isCreatingExam: false,
            createExamErrorMessage: failure,
          ),
        );
    }
  }

  Future<void> addQuestion(AddExamQuestionRequestEntity requestEntity) async {
    emit(
      state.copyWith(
        isAddingQuestion: true,
        addQuestionErrorMessage: null,
        addQuestionSuccessMessage: null,
      ),
    );

    final result = await _addExamQuestionUseCase(requestEntity);
    switch (result) {
      case ApiSuccessResult(data: final data):
        final updatedQuestions = [...state.addedQuestions, data];
        emit(
          state.copyWith(
            isAddingQuestion: false,
            addQuestionErrorMessage: null,
            addQuestionSuccessMessage: 'Question added successfully',
            publishedExam: state.publishedExam?.copyWith(
              questionCount: updatedQuestions.length,
            ),
            addedQuestions: updatedQuestions,
          ),
        );
      case ApiErrorResult(failure: final failure):
        emit(
          state.copyWith(
            isAddingQuestion: false,
            addQuestionErrorMessage: failure,
          ),
        );
    }
  }

  void clearQuestionFeedback() {
    emit(
      state.copyWith(
        addQuestionErrorMessage: null,
        addQuestionSuccessMessage: null,
      ),
    );
  }

  Future<void> publishExam(int examId) async {
    emit(
      state.copyWith(
        isPublishingExam: true,
        publishExamErrorMessage: null,
        publishExamSuccessMessage: null,
      ),
    );

    final result = await _publishExamUseCase(examId);
    switch (result) {
      case ApiSuccessResult(data: final data):
        emit(
          state.copyWith(
            isPublishingExam: false,
            publishExamErrorMessage: null,
            publishExamSuccessMessage: 'Exam published successfully',
            publishedExam: data,
          ),
        );
      case ApiErrorResult(failure: final failure):
        emit(
          state.copyWith(
            isPublishingExam: false,
            publishExamErrorMessage: failure,
          ),
        );
    }
  }

  void clearPublishFeedback() {
    emit(
      state.copyWith(
        publishExamErrorMessage: null,
        publishExamSuccessMessage: null,
      ),
    );
  }
}
