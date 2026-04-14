import 'package:json_annotation/json_annotation.dart';
import 'package:close_gap/features/auth/register/data/model/request/profile_setup_dto.dart';

part 'register_request_dto.g.dart';

@JsonSerializable()
class RegisterRequestDto {
  final String username;
  final String email;
  final String password;
  final String role;
  @JsonKey(name: 'profile_setup')
  final ProfileSetupDto? profileSetup;

  RegisterRequestDto({
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    this.profileSetup,
  });

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestDtoToJson(this);
}
