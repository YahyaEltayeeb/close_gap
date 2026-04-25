import 'package:close_gap/features/projects/data/model/request/create_project_request_dto.dart';
import 'package:close_gap/features/projects/data/model/response/project_dto.dart';
import 'package:close_gap/features/projects/data/model/response/skill_dto.dart';

abstract class ProjectsDs {
  Future<List<ProjectDto>> getProjects();

  Future<List<ProjectDto>> getSuggestedProjects();

  Future<List<SkillDto>> getSkills();

  Future<void> createProject(CreateProjectRequestDto requestDto);

  Future<void> deleteProject(int projectId);
}
