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
    String? errorMessage,
  }) {
    return LoginState(
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userModelLoginEntity: userModelLoginEntity ?? this.userModelLoginEntity,
    );
  }
}
