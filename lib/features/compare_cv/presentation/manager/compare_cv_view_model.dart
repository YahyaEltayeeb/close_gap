import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/compare_cv/domain/use_case/compare_cv_use_case.dart';
import 'package:close_gap/features/compare_cv/presentation/manager/compare_cv_event.dart';
import 'package:close_gap/features/compare_cv/presentation/manager/compare_cv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompareCvViewModel extends Cubit<CompareCvState> {
  final CompareCvUseCase _compareCvUseCase;
  CompareCvViewModel(this._compareCvUseCase) : super(CompareCvState());

  void doIntent(CompareCvEvent event) {
    switch (event) {
      case SubmitCompareCvEvent():
        _compareCv(event.post);
    }
  }

  void _compareCv(post) async {
    emit(state.copyWith(isLoadingCompareCv: true));
    var result = await _compareCvUseCase.call(post);
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isLoadingCompareCv: false,
            compareCvResult: result.data,
          ),
        );
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoadingCompareCv: false,
            errorMesCompareCv: result.failure.toString(),
          ),
        );
    }
  }
}
