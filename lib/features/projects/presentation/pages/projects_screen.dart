import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/projects/domain/entities/project_entity.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';
import 'package:close_gap/features/projects/presentation/manager/projects_cubit.dart';
import 'package:close_gap/features/projects/presentation/manager/projects_state.dart';
import 'package:close_gap/features/projects/presentation/widgets/add_project_sheet.dart';
import 'package:close_gap/features/projects/presentation/widgets/empty_projects_card.dart';
import 'package:close_gap/features/projects/presentation/widgets/project_card.dart';
import 'package:close_gap/features/projects/presentation/widgets/projects_loading_view.dart';
import 'package:close_gap/features/projects/presentation/widgets/suggested_projects_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProjectsCubit>()..loadProjects(),
      child: const _ProjectsView(),
    );
  }
}

class _ProjectsView extends StatelessWidget {
  const _ProjectsView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsCubit, ProjectsState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ToastMessage.toastMsg(
            state.errorMessage!,
            backgroundColor: AppColors.red,
          );
          context.read<ProjectsCubit>().clearFeedback();
        }
        if (state.successMessage != null) {
          ToastMessage.toastMsg(state.successMessage!);
          context.read<ProjectsCubit>().clearFeedback();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FB),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF6F8FB),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              tooltip: 'Back',
            ),
            title: const Text(
              'My Projects',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: state.isLoading
                          ? null
                          : () => _showAddProjectSheet(context, state.skills),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.lightPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text(
                        'Add',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: state.isLoading
                          ? null
                          : () => _showSuggestedProjectsSheet(
                              context,
                              state.suggestedProjects,
                            ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      icon: const Icon(Icons.lightbulb_outline_rounded),
                      label: const Text(
                        'Suggested',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: state.isLoading
              ? const ProjectsLoadingView()
              : RefreshIndicator(
                  onRefresh: () => context.read<ProjectsCubit>().loadProjects(),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 110),
                    children: [
                     
                      if (state.myProjects.isEmpty)
                        const EmptyProjectsCard(
                          title: 'No projects yet',
                          subtitle:
                              'Use Add Project to publish your first project.',
                        )
                      else
                        ...state.myProjects.map(
                          (project) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ProjectCard(
                              project: project,
                              isOwnedProject: true,
                              isBusy: state.isDeleting,
                              onDelete: () => _confirmDelete(context, project),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    ProjectEntity project,
  ) async {
    final cubit = context.read<ProjectsCubit>();
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete project'),
          content: Text('Delete "${project.title}" from your projects?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await cubit.deleteProject(project.id);
    }
  }

  Future<void> _showAddProjectSheet(
    BuildContext context,
    List<SkillEntity> skills,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ProjectsCubit>(),
        child: AddProjectSheet(skills: skills),
      ),
    );
  }

  Future<void> _showSuggestedProjectsSheet(
    BuildContext context,
    List<ProjectEntity> projects,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SuggestedProjectsSheet(projects: projects),
    );
  }
}
