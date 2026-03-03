import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/domain/use_case/register_use_case.dart';
import 'package:close_gap/features/auth/register/presentation/manager/register_event.dart';
import 'package:close_gap/features/auth/register/presentation/manager/register_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterState> {
  RegisterViewModel(this._registerUseCase) : super(RegisterState());
  final RegisterUseCase _registerUseCase;
  void doIntent(RegisterEvent event) {
    switch (event) {
      case RegisterSubmitEvent():
        registerUser(event.requestEntity);
    }
  }

  void registerUser(RegisterRequestEntity requestEntity) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    var result = await _registerUseCase.call(requestEntity);
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            userEntity: result.data,
          ),
        );
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: result.failure.toString(),
          ),
        );
    }
  }
}
