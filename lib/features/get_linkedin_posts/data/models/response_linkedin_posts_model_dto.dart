import 'package:json_annotation/json_annotation.dart';

part 'response_linkedin_posts_model_dto.g.dart';

@JsonSerializable()
class LinkedinPostsResponseDto {
  final int count;
  final List<LinkedinPostDto> posts;

  const LinkedinPostsResponseDto({
    required this.count,
    required this.posts,
  });

  factory LinkedinPostsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LinkedinPostsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LinkedinPostsResponseDtoToJson(this);
}

@JsonSerializable()
class LinkedinPostDto {
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

  const LinkedinPostDto({
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

  factory LinkedinPostDto.fromJson(Map<String, dynamic> json) =>
      _$LinkedinPostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LinkedinPostDtoToJson(this);
}
