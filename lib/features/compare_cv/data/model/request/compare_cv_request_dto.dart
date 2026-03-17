import 'package:json_annotation/json_annotation.dart';

part 'compare_cv_request_dto.g.dart';

@JsonSerializable()
class CompareCvRequestDto {
  @JsonKey(name: 'job_description')
  final JobDescriptionDto jobDescription;

  CompareCvRequestDto({required this.jobDescription});

  factory CompareCvRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CompareCvRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CompareCvRequestDtoToJson(this);
}

@JsonSerializable()
class JobDescriptionDto {
  @JsonKey(name: 'job_title')
  final String jobTitle;

  @JsonKey(name: 'company_name')
  final String companyName;

  @JsonKey(name: 'required_skills')
  final List<String> requiredSkills;

  @JsonKey(name: 'preferred_skills')
  final List<String>? preferredSkills;

  @JsonKey(name: 'experience_years')
  final String experienceYears;

  @JsonKey(name: 'education_required')
  final List<String>? educationRequired;

  @JsonKey(name: 'languages_required')
  final List<String>? languagesRequired;

  @JsonKey(name: 'job_description')
  final String jobDescription;

  @JsonKey(name: 'post_url')
  final String postUrl;

  @JsonKey(name: 'hr_email')
  final String? hrEmail;

  JobDescriptionDto({
    required this.jobTitle,
    required this.companyName,
    required this.requiredSkills,
    this.preferredSkills,
    required this.experienceYears,
    this.educationRequired,
    this.languagesRequired,
    required this.jobDescription,
    required this.postUrl,
    this.hrEmail,
  });

  factory JobDescriptionDto.fromJson(Map<String, dynamic> json) =>
      _$JobDescriptionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$JobDescriptionDtoToJson(this);
}
