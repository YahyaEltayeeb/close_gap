import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/projects/domain/repo/projects_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateProjectUseCase {
  final ProjectsRepo _projectsRepo;

  CreateProjectUseCase(this._projectsRepo);

  Future<ApiResult<void>> call({
    required String title,
    required String description,
    required String githubUrl,
    required String demoUrl,
    required List<String> skills,
  }) {
    return _projectsRepo.createProject(
      title: title,
      description: description,
      githubUrl: githubUrl,
      demoUrl: demoUrl,
      skills: skills,
    );
  }
}
