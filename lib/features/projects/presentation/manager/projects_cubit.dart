import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/projects/domain/use_case/create_project_use_case.dart';
import 'package:close_gap/features/projects/domain/use_case/delete_project_use_case.dart';
import 'package:close_gap/features/projects/domain/use_case/get_projects_use_case.dart';
import 'package:close_gap/features/projects/domain/use_case/get_skills_use_case.dart';
import 'package:close_gap/features/projects/domain/use_case/get_suggested_projects_use_case.dart';
import 'package:close_gap/features/projects/presentation/manager/projects_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProjectsCubit extends Cubit<ProjectsState> {
  final GetProjectsUseCase _getProjectsUseCase;
  final GetSuggestedProjectsUseCase _getSuggestedProjectsUseCase;
  final GetSkillsUseCase _getSkillsUseCase;
  final CreateProjectUseCase _createProjectUseCase;
  final DeleteProjectUseCase _deleteProjectUseCase;

  ProjectsCubit(
    this._getProjectsUseCase,
    this._getSuggestedProjectsUseCase,
    this._getSkillsUseCase,
    this._createProjectUseCase,
    this._deleteProjectUseCase,
  ) : super(const ProjectsState());

  Future<void> loadProjects() async {
    emit(
      state.copyWith(isLoading: true, errorMessage: null, successMessage: null),
    );

    final myProjectsResponse = await _getProjectsUseCase();
    final suggestedResponse = await _getSuggestedProjectsUseCase();
    final skillsResponse = await _getSkillsUseCase();
    final myProjects = switch (myProjectsResponse) {
      ApiSuccessResult<List<dynamic>>(data: final data) => data.cast(),
      _ => <dynamic>[],
    };
    final suggestedProjects = switch (suggestedResponse) {
      ApiSuccessResult<List<dynamic>>(data: final data) => data.cast(),
      _ => <dynamic>[],
    };
    final skills = switch (skillsResponse) {
      ApiSuccessResult<List<dynamic>>(data: final data) => data.cast(),
      _ => <dynamic>[],
    };

    String? errorMessage;
    if (myProjectsResponse case ApiErrorResult(failure: final failure)) {
      errorMessage = failure;
    } else if (suggestedResponse case ApiErrorResult(failure: final failure)) {
      errorMessage = failure;
    } else if (skillsResponse case ApiErrorResult(failure: final failure)) {
      errorMessage = failure;
    }

    emit(
      state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
        myProjects: myProjects.cast(),
        suggestedProjects: suggestedProjects.cast(),
        skills: skills.cast(),
      ),
    );
  }

  Future<bool> createProject({
    required String title,
    required String description,
    required String githubUrl,
    required String demoUrl,
    required List<String> skills,
  }) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _createProjectUseCase(
      title: title,
      description: description,
      githubUrl: githubUrl,
      demoUrl: demoUrl,
      skills: skills,
    );

    if (result case ApiErrorResult(failure: final failure)) {
      emit(state.copyWith(isSubmitting: false, errorMessage: failure));
      return false;
    }

    emit(
      state.copyWith(
        isSubmitting: false,
        successMessage: 'Project added successfully',
      ),
    );
    await loadProjects();
    return true;
  }

  Future<void> deleteProject(int projectId) async {
    emit(
      state.copyWith(
        isDeleting: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _deleteProjectUseCase(projectId);
    if (result case ApiErrorResult(failure: final failure)) {
      emit(state.copyWith(isDeleting: false, errorMessage: failure));
      return;
    }

    emit(
      state.copyWith(
        isDeleting: false,
        successMessage: 'Project deleted successfully',
      ),
    );
    await loadProjects();
  }

  void clearFeedback() {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }
}
