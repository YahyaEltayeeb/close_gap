import 'package:json_annotation/json_annotation.dart';

part 'compare_cv_response_dto.g.dart';

@JsonSerializable()
class CompareCvResponseDto {
  final int score;

  @JsonKey(name: 'matched_skills')
  final List<String> matchedSkills;

  @JsonKey(name: 'unmatched_skills')
  final List<String> unmatchedSkills;

  @JsonKey(name: 'experience_match')
  final bool experienceMatch;

  @JsonKey(name: 'education_match')
  final bool educationMatch;

  final String analysis;

  @JsonKey(name: 'hr_email')
  final String? hrEmail;

  CompareCvResponseDto({
    required this.score,
    required this.matchedSkills,
    required this.unmatchedSkills,
    required this.experienceMatch,
    required this.educationMatch,
    required this.analysis,
    this.hrEmail,
  });

  factory CompareCvResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CompareCvResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CompareCvResponseDtoToJson(this);
}
