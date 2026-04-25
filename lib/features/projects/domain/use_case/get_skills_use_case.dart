import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';
import 'package:close_gap/features/projects/domain/repo/projects_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSkillsUseCase {
  final ProjectsRepo _projectsRepo;

  GetSkillsUseCase(this._projectsRepo);

  Future<ApiResult<List<SkillEntity>>> call() {
    return _projectsRepo.getSkills();
  }
}
