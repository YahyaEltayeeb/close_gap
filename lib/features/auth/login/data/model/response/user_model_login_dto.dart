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
  @JsonKey(name: "track_id")
  final int? trackId;
  @JsonKey(name: "track_name")
  final String? trackName;
  final int? year;
  @JsonKey(name: "current_semester")
  final int? currentSemester;
  @JsonKey(name: "department_id")
  final int? departmentId;
  final Map<String, dynamic>? profile;
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
  @JsonKey(name: "skill_gaps")
  final List<dynamic>? skillGaps;
  final List<dynamic>? skills;

  UserModelLoginDto({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.githubUrl,
    required this.linkedinUrl,
    required this.role,
    required this.trackId,
    required this.trackName,
    required this.year,
    required this.currentSemester,
    required this.departmentId,
    required this.profile,
    required this.isActive,
    required this.createdAt,
    required this.lastLogin,
    required this.certificates,
    required this.courseProgress,
    required this.exams,
    required this.notifications,
    required this.skillGaps,
    required this.skills,
  });

  factory UserModelLoginDto.fromJson(Map<String, dynamic> json) =>
      _$UserModelLoginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelLoginDtoToJson(this);
}
