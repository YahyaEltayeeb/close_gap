import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/projects/domain/entities/project_entity.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';

abstract class ProjectsRepo {
  Future<ApiResult<List<ProjectEntity>>> getProjects();

  Future<ApiResult<List<ProjectEntity>>> getSuggestedProjects();

  Future<ApiResult<List<SkillEntity>>> getSkills();

  Future<ApiResult<void>> createProject({
    required String title,
    required String description,
    required String githubUrl,
    required String demoUrl,
    required List<String> skills,
  });

  Future<ApiResult<void>> deleteProject(int projectId);
}
