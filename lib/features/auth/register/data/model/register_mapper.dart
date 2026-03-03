import 'package:close_gap/features/auth/register/data/model/request/register_request_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/register_response_dto.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/user_register_entity.dart';

extension RegisterToDto on RegisterRequestEntity {
  RegisterRequestDto toDto() {
    return RegisterRequestDto(
      email: email,
      password: password,
      username: name,
      role: role,
    );
  }
}

extension RegisterToEntity on RegisterResponseDto {
  UserEntity toEntity() {
    return UserEntity(
      id: user?.id?? 0,
      name:user?. username??'',
      email: user?.email??'',
    );
  }
}