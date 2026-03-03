import 'package:close_gap/features/auth/login/domain/entities/login_request_entity.dart';

sealed class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  LoginRequestEntity loginRequestEntity;

  LoginSubmitEvent({required this.loginRequestEntity});
}
