import 'package:close_gap/features/get_jobs/data/models/response_get_jobs_model_dto.dart';
import 'package:close_gap/features/get_jobs/domain/entities/get_jobs_entity.dart';

extension JobMapper on GetJobsModelDto {
  GetJobEntity toEntity() {
    return GetJobEntity(
      jobUrl: jobUrl,
      jobTitle: jobTitle,
      companyUrl: companyUrl,
      companyName: companyName,
      location: location,
      isRemote: isRemote,
    );
  }
}
