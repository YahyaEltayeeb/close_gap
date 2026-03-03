import 'package:close_gap/features/auth/register/data/model/response/user_register_model_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_response_dto.g.dart';

@JsonSerializable()
class RegisterResponseDto {
  final bool? ok;
  final UserRegisterModelDto? user;

  RegisterResponseDto({
    required this.ok,
    required this.user,
  });

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseDtoToJson(this);
}
