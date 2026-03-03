import 'package:json_annotation/json_annotation.dart';

part 'user_register_model_dto.g.dart';

@JsonSerializable()
class UserRegisterModelDto {
  final int? id;
  final String? username;
  final String? email;
  final String? role;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "last_login")
  final String? lastLogin;
  @JsonKey(name: "full_name")
  final String? fullName;
  @JsonKey(name: "github_url")
  final String? githubUrl;
  @JsonKey(name: "linkedin_url")
  final String? linkedinUrl;
  final bool? isActive;
  final List<dynamic>? certificates;
  @JsonKey(name: "course_progress")
  final List<dynamic>? courseProgress;
  final List<dynamic>? exams;
  final List<dynamic>? notifications;
  final List<dynamic>? skillGaps;
  final List<dynamic>? skills;
  final dynamic profile;

  UserRegisterModelDto({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.createdAt,
    this.lastLogin,
    this.fullName,
    this.githubUrl,
    this.linkedinUrl,
    required this.isActive,
    required this.certificates,
    required this.courseProgress,
    required this.exams,
    required this.notifications,
    required this.skillGaps,
    required this.skills,
    this.profile,
  });

  factory UserRegisterModelDto.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterModelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterModelDtoToJson(this);
}
