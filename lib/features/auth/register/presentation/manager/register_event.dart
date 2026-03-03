import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';

sealed class RegisterEvent {}

class RegisterSubmitEvent extends RegisterEvent {
  RegisterRequestEntity requestEntity;
  RegisterSubmitEvent({required this.requestEntity});
}
