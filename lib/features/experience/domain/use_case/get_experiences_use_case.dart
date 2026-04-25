import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/experience/domain/entities/experience_item.dart';
import 'package:close_gap/features/experience/domain/repo/experience_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExperiencesUseCase {
  GetExperiencesUseCase(this._experienceRepo);

  final ExperienceRepo _experienceRepo;

  Future<ApiResult<List<ExperienceItem>>> call() {
    return _experienceRepo.getExperiences();
  }
}
