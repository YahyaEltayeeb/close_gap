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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController registerAsController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    registerAsController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    return BlocProvider(
      create: (context) => getIt<RegisterViewModel>(),
      child: BlocListener<RegisterViewModel, RegisterState>(
        listener: (context, state) => {
          if (state.isSuccess)
            {
              context.pushReplacementNamed(AppRoutes.login),
              ToastMessage.toastMsg(locale.register_success),
            }
          else if (state.errorMessage != null)
            {
              ToastMessage.toastMsg(
                state.errorMessage ?? 'An error occurred',
                backgroundColor: AppColors.red,
              ),
            },
        },
        child: Scaffold(
          body: SingleChildScrollView(
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
                      value,
                      passwordController.text,
                    ),
                  ),
                  SizedBox(height: context.height * 0.025),
                  // AuthTextField(
                  //   icon: Icons.mobile_friendly,
                  //   label: locale.mobile_number,
                  //   validator: (value) =>
                  //       Validations.validateEmail(context, value),
                  // ),
                  SizedBox(height: context.height * 0.025),
                  AuthDropdownTextfield(
                    onChanged: (value) {
                      registerAsController.text = value!
                          .toUpperCase()
                          .toString();
                    },
                    icon: Icons.no_encryption,
                    label: locale.register_as,
                    items: ['Student', 'Graduated'],
                    showForgotPassword: false,
                    forgotText: '',
                  ),
                  SizedBox(height: context.height * 0.04),
                  BlocBuilder<RegisterViewModel, RegisterState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<RegisterViewModel>().doIntent(
                              RegisterSubmitEvent(
                                requestEntity: RegisterRequestEntity(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  role: registerAsController.text,
                                ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
