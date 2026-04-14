import 'package:json_annotation/json_annotation.dart';

part 'profile_setup_dto.g.dart';

@JsonSerializable()
class ProfileSetupDto {
  @JsonKey(name: 'university_id')
  final int universityId;
  @JsonKey(name: 'faculty_id')
  final int facultyId;
  @JsonKey(name: 'department_id')
  final int departmentId;
  @JsonKey(name: 'target_track_id')
  final int targetTrackId;
  final int year;
  @JsonKey(name: 'current_semester')
  final int currentSemester;
  @JsonKey(name: 'path_type')
  final String pathType;

  const ProfileSetupDto({
    required this.universityId,
    required this.facultyId,
    required this.departmentId,
    required this.targetTrackId,
    required this.year,
    required this.currentSemester,
    required this.pathType,
  });

  factory ProfileSetupDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileSetupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileSetupDtoToJson(this);
}
