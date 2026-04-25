import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/teacher_past_exams/domain/use_case/get_my_teacher_exams_use_case.dart';
import 'package:close_gap/features/teacher_past_exams/presentation/manager/teacher_past_exams_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TeacherPastExamsCubit extends Cubit<TeacherPastExamsState> {
  final GetMyTeacherExamsUseCase _getMyTeacherExamsUseCase;

  TeacherPastExamsCubit(this._getMyTeacherExamsUseCase)
    : super(const TeacherPastExamsState());

  Future<void> getMyExams() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getMyTeacherExamsUseCase();
    switch (result) {
      case ApiSuccessResult(data: final data):
        emit(state.copyWith(isLoading: false, errorMessage: null, exams: data));
      case ApiErrorResult(failure: final failure):
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failure,
            exams: const [],
          ),
        );
    }
  }
}
