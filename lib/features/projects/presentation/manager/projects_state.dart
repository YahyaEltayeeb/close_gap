import 'package:close_gap/features/projects/domain/entities/project_entity.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';

class ProjectsState {
  static const _sentinel = Object();

  final bool isLoading;
  final bool isSubmitting;
  final bool isDeleting;
  final String? errorMessage;
  final String? successMessage;
  final List<ProjectEntity> myProjects;
  final List<ProjectEntity> suggestedProjects;
  final List<SkillEntity> skills;

  const ProjectsState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.isDeleting = false,
    this.errorMessage,
    this.successMessage,
    this.myProjects = const [],
    this.suggestedProjects = const [],
    this.skills = const [],
  });

  ProjectsState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    bool? isDeleting,
    Object? errorMessage = _sentinel,
    Object? successMessage = _sentinel,
    List<ProjectEntity>? myProjects,
    List<ProjectEntity>? suggestedProjects,
    List<SkillEntity>? skills,
  }) {
    return ProjectsState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isDeleting: isDeleting ?? this.isDeleting,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      successMessage: identical(successMessage, _sentinel)
          ? this.successMessage
          : successMessage as String?,
      myProjects: myProjects ?? this.myProjects,
      suggestedProjects: suggestedProjects ?? this.suggestedProjects,
      skills: skills ?? this.skills,
    );
  }
}
