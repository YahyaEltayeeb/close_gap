import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/experience/domain/entities/experience_item.dart';
import 'package:close_gap/features/experience/domain/entities/experience_request_entity.dart';

abstract class ExperienceRepo {
  Future<ApiResult<List<ExperienceItem>>> getExperiences();

  Future<ApiResult<void>> createExperience(
    ExperienceRequestEntity requestEntity,
  );

  Future<ApiResult<void>> updateExperience(
    int experienceId,
    ExperienceRequestEntity requestEntity,
  );

  Future<ApiResult<void>> deleteExperience(int experienceId);
}
