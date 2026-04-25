import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/projects/data/data_source/projects_ds.dart';
import 'package:close_gap/features/projects/data/model/request/create_project_request_dto.dart';
import 'package:close_gap/features/projects/data/model/response/project_dto.dart';
import 'package:close_gap/features/projects/data/model/response/skill_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProjectsDs)
class ProjectsDsImp implements ProjectsDs {
  final ApiServices _apiServices;

  ProjectsDsImp(this._apiServices);

  List<dynamic> _extractList(dynamic response) {
    if (response is List) return response;
    if (response is Map<String, dynamic>) {
      for (final key in [
        'data',
        'results',
        'projects',
        'items',
        'skills',
        'suggestions',
      ]) {
        final value = response[key];
        if (value is List) return value;
      }
    }
    throw Exception('Unexpected response format');
  }

  @override
  Future<void> createProject(CreateProjectRequestDto requestDto) {
    return _apiServices.createProject(requestDto);
  }

  @override
  Future<void> deleteProject(int projectId) {
    return _apiServices.deleteProject(projectId);
  }

  @override
  Future<List<ProjectDto>> getProjects() async {
    final response = await _apiServices.getProjects();
    final rawList = _extractList(response);
    return rawList
        .map((item) => ProjectDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SkillDto>> getSkills() async {
    final response = await _apiServices.getSkills();
    final rawList = _extractList(response);
    return rawList
        .map((item) => SkillDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ProjectDto>> getSuggestedProjects() async {
    final response = await _apiServices.getSuggestedProjects();
    final rawList = _extractList(response);
    return rawList
        .map((item) => ProjectDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
