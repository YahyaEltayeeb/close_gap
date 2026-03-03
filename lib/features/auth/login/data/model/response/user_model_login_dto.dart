import 'package:json_annotation/json_annotation.dart';

part 'user_model_login_dto.g.dart';

@JsonSerializable()
class UserModelLoginDto {
  final int? id;
  final String? username;
  final String? email;
  @JsonKey(name: "full_name")
  final String? fullName;
  @JsonKey(name: "github_url")
  final String? githubUrl;
  @JsonKey(name: "linkedin_url")
  final String? linkedinUrl;
  final String? role;
  @JsonKey(name: "is_active")
  final bool isActive;

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "last_login")
  final String? lastLogin;

  final List<dynamic>? certificates;
  @JsonKey(name: "course_progress")
  final List<dynamic>? courseProgress;
  final List<dynamic>? exams;
  final List<dynamic>? notifications;
  final List<dynamic>? skill_gaps;
  final List<dynamic>? skills;

  UserModelLoginDto({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.githubUrl,
    required this.linkedinUrl,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.lastLogin,
    required this.certificates,
    required this.courseProgress,
    required this.exams,
    required this.notifications,
    required this.skill_gaps,
    required this.skills,
  });

  factory UserModelLoginDto.fromJson(Map<String, dynamic> json) =>
      _$UserModelLoginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelLoginDtoToJson(this);
}
