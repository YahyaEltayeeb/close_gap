import 'package:close_gap/features/projects/data/model/response/project_dto.dart';
import 'package:close_gap/features/projects/data/model/response/skill_dto.dart';
import 'package:close_gap/features/projects/domain/entities/project_entity.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';

extension ProjectDtoMapper on ProjectDto {
  ProjectEntity toEntity() {
    return ProjectEntity(
      id: id ?? 0,
      title: (title ?? '').trim(),
      description: (description ?? '').trim(),
      githubUrl: (githubUrl ?? '').trim(),
      demoUrl: (demoUrl ?? '').trim(),
      skills: skills ?? const [],
    );
  }
}

extension SkillDtoMapper on SkillDto {
  SkillEntity toEntity() {
    return SkillEntity(
      id: id ?? 0,
      name: (name ?? '').trim(),
      description: description?.trim(),
      trackId: trackId,
      type: (type ?? '').trim(),
    );
  }
}
