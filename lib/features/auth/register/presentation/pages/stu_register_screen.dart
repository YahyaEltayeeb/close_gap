import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/routing/routing_extensions.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/components/custom_elevated_button.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/core/helpers/validators.dart';
import 'package:close_gap/features/auth/common/auth_dropdown_textfield.dart';
import 'package:close_gap/features/auth/common/auth_logo.dart';
import 'package:close_gap/features/auth/register/domain/entities/academic_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/profile_setup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/semester_lookup_entity.dart';
import 'package:close_gap/features/auth/register/presentation/manager/register_event.dart';
import 'package:close_gap/features/auth/register/presentation/manager/register_state.dart';
import 'package:close_gap/features/auth/register/presentation/manager/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StuRegisterScreen extends StatelessWidget {
  final RegisterRequestEntity requestEntity;

  const StuRegisterScreen({
    super.key,
    required this.requestEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterViewModel>()..loadInitialStudentData(),
      child: _StuRegisterView(requestEntity: requestEntity),
    );
  }
}

class _StuRegisterView extends StatefulWidget {
  final RegisterRequestEntity requestEntity;

  const _StuRegisterView({
    required this.requestEntity,
  });

  @override
  State<_StuRegisterView> createState() => _StuRegisterViewState();
}

class _StuRegisterViewState extends State<_StuRegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AcademicLookupEntity? _selectedUniversity;
  AcademicLookupEntity? _selectedFaculty;
  AcademicLookupEntity? _selectedDepartment;
  AcademicLookupEntity? _selectedTrack;
  int? _selectedYear;
  SemesterLookupEntity? _selectedSemester;

  Widget _buildFixedRoleField(BuildContext context, String label, String value) {
    return SizedBox(
      width: context.width * 0.85,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: context.colorScheme.onSurface),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.width * 0.03),
            borderSide: BorderSide(
              color: context.colorScheme.onSurface,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.width * 0.03),
            borderSide: BorderSide(
              color: context.colorScheme.onSurface,
              width: 1.5,
            ),
          ),
          prefixIcon: Icon(
            Icons.person_outline,
            size: context.width * 0.06,
            color: context.colorScheme.onSurface,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: context.height * 0.015,
            horizontal: context.width * 0.04,
          ),
        ),
        child: Text(
          value,
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }

  AcademicLookupEntity? _findAcademicByName(
    List<AcademicLookupEntity> items,
    String? value,
  ) {
    for (final item in items) {
      if (item.name == value) {
        return item;
      }
    }
    return null;
  }

  SemesterLookupEntity? _findSemesterByLabel(
    List<SemesterLookupEntity> items,
    String? value,
  ) {
    for (final item in items) {
      if (item.label == value) {
        return item;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.localization;
    return BlocListener<RegisterViewModel, RegisterState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.lookupErrorMessage != current.lookupErrorMessage ||
          previous.isSuccess != current.isSuccess,
      listener: (context, state) {
        if (state.lookupErrorMessage != null) {
          ToastMessage.toastMsg(
            state.lookupErrorMessage!,
            backgroundColor: AppColors.red,
          );
        } else if (state.errorMessage != null) {
          ToastMessage.toastMsg(
            state.errorMessage!,
            backgroundColor: AppColors.red,
          );
        } else if (state.isSuccess) {
          ToastMessage.toastMsg(locale.register_success);
          context.pushNamedAndRemoveUntil(
            AppRoutes.login,
            predicate: (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: BlocBuilder<RegisterViewModel, RegisterState>(
              builder: (context, state) {
                final years = state.semesters
                    .map((item) => item.year)
                    .toSet()
                    .toList()
                  ..sort();
                final filteredSemesters = _selectedYear == null
                    ? <SemesterLookupEntity>[]
                    : state.semesters
                          .where((item) => item.year == _selectedYear)
                          .toList();

                return Column(
                  children: [
                    AuthLogo(
                      desc: locale.enter_your_details_to_register,
                      pross: locale.register,
                    ),
                    if (state.isLookupLoading)
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: CircularProgressIndicator(),
                      ),
                    SizedBox(height: context.height * 0.05),
                    _buildFixedRoleField(
                      context,
                      locale.student,
                      locale.student,
                    ),
                    SizedBox(height: context.height * 0.025),
                    AuthDropdownTextfield(
                      value: _selectedUniversity?.name,
                      icon: Icons.account_balance_outlined,
                      label: locale.university,
                      items: state.universities.map((item) => item.name).toList(),
                      validator: (value) =>
                          Validations.validateRequired(context, value),
                      showForgotPassword: false,
                      forgotText: '',
                      onChanged: (value) {
                        context
                            .read<RegisterViewModel>()
                            .clearSubmissionFeedback();
                        final selected = _findAcademicByName(
                          state.universities,
                          value,
                        );
                        if (selected == null) {
                          return;
                        }

                        setState(() {
                          _selectedUniversity = selected;
                          _selectedFaculty = null;
                          _selectedDepartment = null;
                          _selectedYear = null;
                          _selectedSemester = null;
                        });
                        context.read<RegisterViewModel>().loadFaculties(
                          selected.id,
                        );
                      },
                    ),
                    SizedBox(height: context.height * 0.025),
                    AuthDropdownTextfield(
                      value: _selectedFaculty?.name,
                      icon: Icons.school_outlined,
                      label: locale.collage,
                      items: state.faculties.map((item) => item.name).toList(),
                      validator: (value) =>
                          Validations.validateRequired(context, value),
                      showForgotPassword: false,
                      forgotText: '',
                      onChanged: (value) {
                        context
                            .read<RegisterViewModel>()
                            .clearSubmissionFeedback();
                        final selected = _findAcademicByName(
                          state.faculties,
                          value,
                        );
                        if (selected == null) {
                          return;
                        }

                        setState(() {
                          _selectedFaculty = selected;
                          _selectedDepartment = null;
                          _selectedYear = null;
                          _selectedSemester = null;
                        });
                        context.read<RegisterViewModel>().loadDepartments(
                          selected.id,
                        );
                      },
                    ),
                    SizedBox(height: context.height * 0.025),
                    AuthDropdownTextfield(
                      value: _selectedDepartment?.name,
                      icon: Icons.menu_book_outlined,
                      label: locale.department,
                      items: state.departments.map((item) => item.name).toList(),
                      validator: (value) =>
                          Validations.validateRequired(context, value),
                      showForgotPassword: false,
                      forgotText: '',
                      onChanged: (value) {
                        context
                            .read<RegisterViewModel>()
                            .clearSubmissionFeedback();
                        final selected = _findAcademicByName(
                          state.departments,
                          value,
                        );
                        if (selected == null) {
                          return;
                        }

                        setState(() {
                          _selectedDepartment = selected;
                          _selectedYear = null;
                          _selectedSemester = null;
                        });
                        context.read<RegisterViewModel>().loadSemesters(
                          selected.id,
                        );
                      },
                    ),
                    SizedBox(height: context.height * 0.025),
                    AuthDropdownTextfield(
                      value: _selectedYear?.toString(),
                      icon: Icons.calendar_today_outlined,
                      label: locale.current_year,
                      items: years.map((item) => item.toString()).toList(),
                      validator: (value) =>
                          Validations.validateRequired(context, value),
                      showForgotPassword: false,
                      forgotText: '',
                      onChanged: (value) {
                        context
                            .read<RegisterViewModel>()
                            .clearSubmissionFeedback();
                        setState(() {
                          _selectedYear = int.tryParse(value ?? '');
                          _selectedSemester = null;
                        });
                      },
                    ),
                    SizedBox(height: context.height * 0.025),
                    AuthDropdownTextfield(
                      value: _selectedSemester?.label,
                      icon: Icons.timelapse_outlined,
                      label: locale.semester,
                      items: filteredSemesters
                          .map((item) => item.label)
                          .toList(),
                      validator: (value) =>
                          Validations.validateRequired(context, value),
                      showForgotPassword: false,
                      forgotText: '',
                      onChanged: (value) {
                        context
                            .read<RegisterViewModel>()
                            .clearSubmissionFeedback();
                        final selected = _findSemesterByLabel(
                          filteredSemesters,
                          value,
                        );
                        setState(() {
                          _selectedSemester = selected;
                        });
                      },
                    ),
                    SizedBox(height: context.height * 0.025),
                    AuthDropdownTextfield(
                      value: _selectedTrack?.name,
                      icon: Icons.track_changes_outlined,
                      label: locale.track,
                      items: state.tracks.map((item) => item.name).toList(),
                      validator: (value) =>
                          Validations.validateRequired(context, value),
                      showForgotPassword: false,
                      forgotText: '',
                      onChanged: (value) {
                        context
                            .read<RegisterViewModel>()
                            .clearSubmissionFeedback();
                        final selected = _findAcademicByName(
                          state.tracks,
                          value,
                        );
                        setState(() {
                          _selectedTrack = selected;
                        });
                      },
                    ),
                    SizedBox(height: context.height * 0.04),
                    CustomElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        if (_selectedUniversity == null ||
                            _selectedFaculty == null ||
                            _selectedDepartment == null ||
                            _selectedTrack == null ||
                            _selectedYear == null ||
                            _selectedSemester == null) {
                          ToastMessage.toastMsg(
                            locale.this_field_is_required,
                            backgroundColor: AppColors.red,
                          );
                          return;
                        }

                        context.read<RegisterViewModel>().doIntent(
                          RegisterSubmitEvent(
                            requestEntity: widget.requestEntity.copyWith(
                              profileSetup: ProfileSetupEntity(
                                universityId: _selectedUniversity!.id,
                                facultyId: _selectedFaculty!.id,
                                departmentId: _selectedDepartment!.id,
                                targetTrackId: _selectedTrack!.id,
                                year: _selectedYear!,
                                currentSemester: _selectedSemester!.semester,
                              ),
                            ),
                          ),
                        );
                      },
                      isLoading: state.isLoading,
                      widget: Text(
                        locale.next,
                        style: context.textTheme.displayMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
