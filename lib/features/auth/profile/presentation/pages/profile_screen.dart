import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/components/custom_elevated_button.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/auth/common/auth_dropdown_textfield.dart';
import 'package:close_gap/features/auth/profile/presentation/manager/profile_state.dart';
import 'package:close_gap/features/auth/profile/presentation/manager/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileViewModel>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final locale = context.localization;

    return BlocListener<ProfileViewModel, ProfileState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ToastMessage.toastMsg(
            state.errorMessage!,
            backgroundColor: AppColors.red,
          );
        } else if (state.successMessage != null) {
          ToastMessage.toastMsg(state.successMessage!);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileViewModel, ProfileState>(
            builder: (context, state) {
              final infoRows = <({String label, String value})>[
                (label: 'Name', value: state.name),
                (label: 'Email', value: state.email),
                (label: 'Role', value: state.role),
                (label: 'Path type', value: state.pathType ?? ''),
                (label: 'University', value: state.universityName ?? ''),
                (label: 'Faculty', value: state.facultyName ?? ''),
                (label: 'Department', value: state.departmentName ?? ''),
              ].where((item) => item.value.trim().isNotEmpty).toList();
              final years =
                  state.semesters.map((item) => item.year).toSet().toList()
                    ..sort();
              final filteredSemesters = state.selectedYear == null
                  ? <String>[]
                  : state.semesters
                        .where((item) => item.year == state.selectedYear)
                        .map((item) => item.label)
                        .toList();

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(locale.profile, style: context.textTheme.displayLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Review your saved academic profile and update track, year and semester.',
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    if (state.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else ...[
                      _ProfileInfoCard(
                        children: infoRows
                            .map(
                              (item) => _ProfileInfoRow(
                                label: item.label,
                                value: item.value,
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      _ProfileInfoCard(
                        children: [
                          Text(
                            'Academic settings',
                            style: context.textTheme.displayMedium,
                          ),
                          const SizedBox(height: 16),
                          AuthDropdownTextfield(
                            value: state.selectedTrack?.name,
                            icon: Icons.track_changes_outlined,
                            label: locale.track,
                            items: state.tracks
                                .map((item) => item.name)
                                .toList(),
                            onChanged: context
                                .read<ProfileViewModel>()
                                .onTrackChanged,
                            validator: (_) => null,
                            showForgotPassword: false,
                            forgotText: '',
                          ),
                          const SizedBox(height: 16),
                          AuthDropdownTextfield(
                            value: state.selectedYear?.toString(),
                            icon: Icons.calendar_today_outlined,
                            label: locale.current_year,
                            items: years
                                .map((item) => item.toString())
                                .toList(),
                            onChanged: context
                                .read<ProfileViewModel>()
                                .onYearChanged,
                            validator: (_) => null,
                            showForgotPassword: false,
                            forgotText: '',
                          ),
                          const SizedBox(height: 16),
                          AuthDropdownTextfield(
                            value: state.selectedSemester?.label,
                            icon: Icons.timelapse_outlined,
                            label: locale.semester,
                            items: filteredSemesters,
                            onChanged: context
                                .read<ProfileViewModel>()
                                .onSemesterChanged,
                            validator: (_) => null,
                            showForgotPassword: false,
                            forgotText: '',
                          ),
                          const SizedBox(height: 20),
                          if (!state.canEditAcademicProfile)
                            Text(
                              'This account is missing saved university, faculty, or department data, so profile editing is currently unavailable.',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.red,
                              ),
                            ),
                          const SizedBox(height: 12),
                          CustomElevatedButton(
                            isLoading: state.isSaving,
                            onPressed:
                                state.isSaving || !state.canEditAcademicProfile
                                ? () {}
                                : context.read<ProfileViewModel>().saveProfile,
                            widget: const Text('Save changes'),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProfileInfoCard extends StatelessWidget {
  const _ProfileInfoCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? '-' : value,
            style: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
