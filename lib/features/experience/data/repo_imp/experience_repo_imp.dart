import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/experience/data/data_source/experience_ds.dart';
import 'package:close_gap/features/experience/data/model/mapper/experience_mapper.dart';
import 'package:close_gap/features/experience/domain/entities/experience_item.dart';
import 'package:close_gap/features/experience/domain/entities/experience_request_entity.dart';
import 'package:close_gap/features/experience/domain/repo/experience_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExperienceRepo)
class ExperienceRepoImp implements ExperienceRepo {
  ExperienceRepoImp(this._experienceDs);

  final ExperienceDs _experienceDs;

  @override
  Future<ApiResult<void>> createExperience(
    ExperienceRequestEntity requestEntity,
  ) {
    return safeApiCall(
      () => _experienceDs.createExperience(requestEntity.toDto()),
    );
  }

  @override
  Future<ApiResult<void>> deleteExperience(int experienceId) {
    return safeApiCall(() => _experienceDs.deleteExperience(experienceId));
  }

  @override
  Future<ApiResult<List<ExperienceItem>>> getExperiences() {
    return safeApiCall(() async {
      final result = await _experienceDs.getExperiences();
      return result.map((item) => item.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<void>> updateExperience(
    int experienceId,
    ExperienceRequestEntity requestEntity,
  ) {
    return safeApiCall(
      () => _experienceDs.updateExperience(experienceId, requestEntity.toDto()),
    );
  }
}
