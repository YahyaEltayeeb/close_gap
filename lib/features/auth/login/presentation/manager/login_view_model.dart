import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:close_gap/features/auth/login/domain/use_case/login_use_case.dart';
import 'package:close_gap/features/auth/login/presentation/manager/login_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel(this._loginUseCase) : super(LoginState());
  final LoginUseCase _loginUseCase;

  void loginUser(LoginRequestEntity loginRequestEntity) async {
    emit(state.copyWith(isLoading: true));
    var result = await _loginUseCase(loginRequestEntity);
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(isLoading: false, userModelLoginEntity: result.data, isSuccess: true),
        );
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: result.failure,
          ),
        );
    }
  }
}
