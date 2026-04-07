import 'package:json_annotation/json_annotation.dart';

part 'response_get_jobs_model_dto.g.dart';

@JsonSerializable()
class GetJobsModelDto {
  @JsonKey(name: 'job_url')
  final String jobUrl;

  @JsonKey(name: 'job_title')
  final String jobTitle;

  @JsonKey(name: 'company_url')
  final String companyUrl;

  @JsonKey(name: 'company_name')
  final String companyName;

  final String location;

  @JsonKey(name: 'is_remote')
  final bool isRemote;

  const GetJobsModelDto({
    required this.jobUrl,
    required this.jobTitle,
    required this.companyUrl,
    required this.companyName,
    required this.location,
    required this.isRemote,
  });

  factory GetJobsModelDto.fromJson(Map<String, dynamic> json) =>
      _$GetJobsModelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetJobsModelDtoToJson(this);
}