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
import 'package:close_gap/features/auth/common/auth_logo.dart';
import 'package:close_gap/features/auth/common/auth_textfield.dart';
import 'package:close_gap/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:close_gap/features/auth/login/presentation/manager/login_state.dart';
import 'package:close_gap/features/auth/login/presentation/manager/login_view_model.dart';
import 'package:close_gap/features/auth/login/widget/login_type.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    return BlocProvider(
      create: (context) => getIt<LoginViewModel>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocListener<LoginViewModel, LoginState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                ToastMessage.toastMsg(
                  state.errorMessage!,
                  backgroundColor: AppColors.red,
                );
              } else if (state.isSuccess) {
                ToastMessage.toastMsg(locale.login_success);
                context.pushNamedAndRemoveUntil(
                  AppRoutes.instructionspage,
                  arguments: 1,
                  predicate: (route) => false,
                );
              }
            },

            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthLogo(
                    desc: locale.enter_your_username_and_password_to_login,
                    pross: locale.login,
                  ),
                  SizedBox(height: context.height * 0.05),
                  AuthTextField(
                    controller: _usernameController,
                    icon: Icons.person,
                    label: locale.username,
                    validator: (value) =>
                        Validations.validateName(context, value),
                  ),
                  SizedBox(height: context.height * 0.04),
                  AuthTextField(
                    controller: _passwordController,
                    icon: Icons.key,
                    label: locale.password,
                    isPassword: true,
                    showForgotPassword: true,
                    validator: (value) =>
                        Validations.validatePassword(context, value),
                  ),
                  SizedBox(height: context.height * 0.025),
                  BlocBuilder<LoginViewModel, LoginState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        widget: Text(locale.login),

                        isLoading: state.isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginViewModel>().loginUser(
                              LoginRequestEntity(
                                userName: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    locale.or_login_with,
                    style: context.textTheme.bodyLarge,
                  ),
                  SizedBox(height: context.height * 0.025),
                  LoginType(),
                  SizedBox(height: context.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        locale.don_t_have_an_account,
                        style: context.textTheme.bodyLarge,
                      ),
                      InkWell(
                        onTap: () {
                          context.pushNamed(AppRoutes.register);
                        },
                        child: Text(
                          locale.register,
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
    );
  }
}
