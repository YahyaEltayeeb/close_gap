import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/projects/data/data_source/projects_ds.dart';
import 'package:close_gap/features/projects/data/model/mapper/projects_mapper.dart';
import 'package:close_gap/features/projects/data/model/request/create_project_request_dto.dart';
import 'package:close_gap/features/projects/domain/entities/project_entity.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';
import 'package:close_gap/features/projects/domain/repo/projects_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProjectsRepo)
class ProjectsRepoImp implements ProjectsRepo {
  final ProjectsDs _projectsDs;

  ProjectsRepoImp(this._projectsDs);

  @override
  Future<ApiResult<void>> createProject({
    required String title,
    required String description,
    required String githubUrl,
    required String demoUrl,
    required List<String> skills,
  }) async {
    return safeApiCall(() async {
      await _projectsDs.createProject(
        CreateProjectRequestDto(
          title: title,
          description: description,
          githubUrl: githubUrl,
          demoUrl: demoUrl,
          skills: skills,
        ),
      );
    });
  }

  @override
  Future<ApiResult<void>> deleteProject(int projectId) async {
    return safeApiCall(() => _projectsDs.deleteProject(projectId));
  }

  @override
  Future<ApiResult<List<ProjectEntity>>> getProjects() async {
    return safeApiCall(() async {
      final result = await _projectsDs.getProjects();
      return result.map((project) => project.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<SkillEntity>>> getSkills() async {
    return safeApiCall(() async {
      final result = await _projectsDs.getSkills();
      return result.map((skill) => skill.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<ProjectEntity>>> getSuggestedProjects() async {
    return safeApiCall(() async {
      final result = await _projectsDs.getSuggestedProjects();
      return result.map((project) => project.toEntity()).toList();
    });
  }
}
