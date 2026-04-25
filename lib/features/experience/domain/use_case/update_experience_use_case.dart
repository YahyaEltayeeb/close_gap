import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/experience/domain/entities/experience_request_entity.dart';
import 'package:close_gap/features/experience/domain/repo/experience_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateExperienceUseCase {
  UpdateExperienceUseCase(this._experienceRepo);

  final ExperienceRepo _experienceRepo;

  Future<ApiResult<void>> call(
    int experienceId,
    ExperienceRequestEntity requestEntity,
  ) {
    return _experienceRepo.updateExperience(experienceId, requestEntity);
  }
}
