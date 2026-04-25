import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/projects/domain/repo/projects_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteProjectUseCase {
  final ProjectsRepo _projectsRepo;

  DeleteProjectUseCase(this._projectsRepo);

  Future<ApiResult<void>> call(int projectId) {
    return _projectsRepo.deleteProject(projectId);
  }
}
