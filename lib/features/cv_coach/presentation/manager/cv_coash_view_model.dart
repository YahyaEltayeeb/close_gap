import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/cv_coach/domain/use_case/cv_coash_use_case.dart';
import 'package:close_gap/features/cv_coach/presentation/manager/cv_coash_event.dart';
import 'package:close_gap/features/cv_coach/presentation/manager/cv_coash_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class CvCoashViewModel extends Cubit<CvCoashState> {
  CvCoashViewModel(this._cvCoashUseCase) : super(CvCoashState());
  final CvCoashUseCase _cvCoashUseCase;

  void doIntent(CvCoashEvent event) {
    switch (event) {
      case SumbitCvEvent():
        _cvCoash(event.file);
    }
  }

  void _cvCoash(File file) async {
    emit(state.copyWith(isLoaddingCvCoash: true));
    var result = await _cvCoashUseCase.call(file);
    print('viewwwwwwmodelllll${result}');
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isLoaddingCvCoash: false,
            cvAnalysisEntity: result.data,
          ),
        );
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoaddingCvCoash: false,
            errorMesCvCoash: result.failure,
          ),
        );
    }
  }
}
