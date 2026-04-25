import 'package:close_gap/features/auth/login/domain/entities/user_model_login_entity.dart';

class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final UserModelLoginEntity? userModelLoginEntity;
  final bool isSuccess;
  LoginState({
    this.isSuccess = false,
    this.userModelLoginEntity,
    this.isLoading = false,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isSuccess,
    UserModelLoginEntity? userModelLoginEntity,
    bool? isLoading,
    Object? errorMessage = _sentinel,
  }) {
    return LoginState(
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage == _sentinel
          ? this.errorMessage
          : errorMessage as String?,
      userModelLoginEntity: userModelLoginEntity ?? this.userModelLoginEntity,
    );
  }
}

const Object _sentinel = Object();
