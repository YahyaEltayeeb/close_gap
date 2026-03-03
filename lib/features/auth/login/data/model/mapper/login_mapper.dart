import 'package:close_gap/features/auth/login/data/model/response/user_model_login_dto.dart';
import 'package:close_gap/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:close_gap/features/auth/login/domain/entities/user_model_login_entity.dart';
import 'package:close_gap/features/auth/login/data/model/request/login_request_dto.dart';

extension LoginMapper on UserModelLoginDto {
  UserModelLoginEntity toEntity() {
    return UserModelLoginEntity(
      id: id ?? 0,
      name: username ?? '',
      email: email ?? '',
      skills: skills?.map((skill) => skill.toString()).toList() ?? [],
    );
  }
}

extension LoginMapperToDto on LoginRequestEntity {
  LoginRequestDto toDto() {
    return LoginRequestDto(username: userName, password: password);
  }
}
