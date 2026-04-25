import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/projects/domain/entities/project_entity.dart';
import 'package:close_gap/features/projects/domain/repo/projects_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProjectsUseCase {
  final ProjectsRepo _projectsRepo;

  GetProjectsUseCase(this._projectsRepo);

  Future<ApiResult<List<ProjectEntity>>> call() {
    return _projectsRepo.getProjects();
  }
}
