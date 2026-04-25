import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/experience/domain/entities/experience_item.dart';
import 'package:close_gap/features/experience/domain/entities/experience_request_entity.dart';
import 'package:close_gap/features/experience/presentation/manager/experience_cubit.dart';
import 'package:close_gap/features/experience/presentation/manager/experience_state.dart';
import 'package:close_gap/features/experience/presentation/models/experience_form_result.dart';
import 'package:close_gap/features/experience/presentation/widgets/empty_experience_card.dart';
import 'package:close_gap/features/experience/presentation/widgets/experience_card.dart';
import 'package:close_gap/features/experience/presentation/widgets/experience_form_sheet.dart';
import 'package:close_gap/features/experience/presentation/widgets/experience_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExperienceCubit>()..loadExperiences(),
      child: BlocConsumer<ExperienceCubit, ExperienceState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ToastMessage.toastMsg(
              state.errorMessage!,
              backgroundColor: AppColors.red,
            );
            context.read<ExperienceCubit>().clearFeedback();
          }
          if (state.successMessage != null) {
            ToastMessage.toastMsg(state.successMessage!);
            context.read<ExperienceCubit>().clearFeedback();
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
              ),
              title: const Text(
                'Experience',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: state.isSubmitting
                  ? null
                  : () => _showExperienceSheet(context),
              backgroundColor: AppColors.lightPrimary,
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              label: const Text(
                'Add Experience',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () =>
                  context.read<ExperienceCubit>().loadExperiences(),
              child: state.isLoading
                  ? const ExperienceLoadingView()
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                          children: [
                           
                            if (state.experiences.isEmpty)
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight - 160,
                                ),
                                child: const Center(
                                  child: EmptyExperienceCard(),
                                ),
                              )
                            else
                              ...state.experiences.map(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: ExperienceCard(
                                    item: item,
                                    onEdit: () => _showExperienceSheet(
                                      context,
                                      item: item,
                                    ),
                                    onDelete: () =>
                                        _deleteExperience(context, item),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showExperienceSheet(
    BuildContext context, {
    ExperienceItem? item,
  }) async {
    final cubit = context.read<ExperienceCubit>();
    final result = await showModalBottomSheet<ExperienceFormResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ExperienceFormSheet(item: item),
    );

    if (!context.mounted || result == null) return;

    final requestEntity = ExperienceRequestEntity(
      companyName: result.companyName,
      title: result.title,
      startDate: _formatApiDate(result.startDate),
      endDate: result.endDate == null ? null : _formatApiDate(result.endDate!),
      description: result.description,
      skills: result.skills,
    );

    if (item == null) {
      await cubit.createExperience(requestEntity);
      return;
    }

    await cubit.updateExperience(item.id, requestEntity);
  }

  Future<void> _deleteExperience(
    BuildContext context,
    ExperienceItem item,
  ) async {
    final cubit = context.read<ExperienceCubit>();
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete experience'),
          content: Text('Delete ${item.title} at ${item.companyName}?'),
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
      await cubit.deleteExperience(item.id);
    }
  }
}

String _formatApiDate(DateTime value) {
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  return '${value.year}-$month-$day';
}
