import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:close_gap/features/auth/common/auth_textfield.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/presentation/manager/register_event.dart';
import 'package:close_gap/features/auth/register/presentation/manager/register_state.dart';
import 'package:close_gap/features/auth/register/presentation/manager/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController teacherKeyController = TextEditingController();
  final TextEditingController registerAsController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    teacherKeyController.dispose();
    registerAsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.localization;
    final roles = [locale.student, locale.teacher];
    return BlocProvider(
      create: (context) => getIt<RegisterViewModel>(),
      child: BlocListener<RegisterViewModel, RegisterState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.pushNamed(AppRoutes.login);
            ToastMessage.toastMsg(locale.register_success);
          } else if (state.errorMessage != null) {
            ToastMessage.toastMsg(
              state.errorMessage ?? locale.an_error_occurred,
              backgroundColor: AppColors.red,
            );
          }
        },
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthLogo(
                          desc: locale.enter_your_details_to_register,
                          pross: locale.register,
                        ),
                        SizedBox(height: context.height * 0.05),
                        AuthTextField(
                          controller: nameController,
                          icon: Icons.person,
                          label: locale.name,
                          validator: (value) =>
                              Validations.validateName(context, value),
                        ),
                        SizedBox(height: context.height * 0.025),
                        AuthTextField(
                          controller: emailController,
                          icon: Icons.email,
                          label: locale.email,
                          validator: (value) =>
                              Validations.validateEmail(context, value),
                        ),
                        SizedBox(height: context.height * 0.025),
                        AuthTextField(
                          controller: passwordController,
                          icon: Icons.key,
                          label: locale.password,
                          isPassword: true,
                          showForgotPassword: false,
                          validator: (value) =>
                              Validations.validatePassword(context, value),
                        ),
                        SizedBox(height: context.height * 0.025),
                        AuthTextField(
                          controller: confirmPasswordController,
                          icon: Icons.key,
                          label: locale.confirm_password,
                          isPassword: true,
                          showForgotPassword: false,
                          validator: (value) => Validations.validateConfirmPassword(
                            context,
                            passwordController.text,
                            value,
                          ),
                        ),
                        SizedBox(height: context.height * 0.025),
                        AuthDropdownTextfield(
                          value: registerAsController.text.isEmpty
                              ? null
                              : registerAsController.text,
                          onChanged: (value) {
                            setState(() {
                              registerAsController.text = value ?? '';
                              if (registerAsController.text != locale.teacher) {
                                teacherKeyController.clear();
                              }
                            });
                          },
                          icon: Icons.no_encryption,
                          label: locale.register_as,
                          items: roles,
                          validator: (value) =>
                              Validations.validateRequired(context, value),
                          showForgotPassword: false,
                          forgotText: '',
                        ),
                        if (registerAsController.text == locale.teacher) ...[
                          SizedBox(height: context.height * 0.025),
                          AuthTextField(
                            controller: teacherKeyController,
                            icon: Icons.lock_outline,
                            label: locale.teacher_key,
                            showForgotPassword: false,
                            validator: (value) {
                              if (registerAsController.text != locale.teacher) {
                                return null;
                              }
                              if (value == null || value.trim().isEmpty) {
                                return locale.teacher_key_required;
                              }
                              if (value.trim() != '2468') {
                                return locale.teacher_key_incorrect;
                              }
                              return null;
                            },
                          ),
                        ],
                        SizedBox(height: context.height * 0.04),
                        BlocBuilder<RegisterViewModel, RegisterState>(
                          builder: (context, state) {
                            return CustomElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  final selectedRole = registerAsController.text
                                      .trim();
                                  final role = selectedRole == locale.teacher
                                      ? 'teacher'
                                      : 'student';
                                  final requestEntity = RegisterRequestEntity(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    role: role,
                                  );

                                  if (role == 'student') {
                                    context.pushNamed(
                                      AppRoutes.stuRegister,
                                      arguments: requestEntity,
                                    );
                                    return;
                                  }

                                  context.read<RegisterViewModel>().doIntent(
                                    RegisterSubmitEvent(
                                      requestEntity: requestEntity,
                                    ),
                                  );
                                }
                              },
                              isLoading: state.isLoading,
                              widget: Text(
                                locale.next,
                                style: context.textTheme.displayMedium!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: context.height * 0.025),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${locale.already_have_an_account} ',
                              style: context.textTheme.bodyLarge,
                            ),
                            InkWell(
                              onTap: () {
                                context.pushNamed(AppRoutes.login);
                              },
                              child: Text(
                                locale.login,
                                style: context.textTheme.displayMedium!.copyWith(
                                  color: AppColors.lightProgress,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
