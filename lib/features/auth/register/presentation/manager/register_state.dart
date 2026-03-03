import 'package:close_gap/features/auth/register/domain/entities/user_register_entity.dart';

class RegisterState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final UserEntity? userEntity;

  RegisterState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.userEntity,
  });

  RegisterState copyWith({
    UserEntity? userEntity,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return RegisterState(
      userEntity: userEntity ?? this.userEntity,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
