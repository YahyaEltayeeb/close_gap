import 'package:flutter/material.dart';
import 'package:close_gap/core/components/custom_elevated_button.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/features/auth/common/auth_dropdown_textfield.dart';
import 'package:close_gap/features/auth/common/auth_logo.dart';

class StuRegisterScreen extends StatefulWidget {
  const StuRegisterScreen({super.key});

  @override
  State<StuRegisterScreen> createState() => _StuRegisterScreenState();
}

class _StuRegisterScreenState extends State<StuRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthLogo(
              desc: locale.enter_your_details_to_register,
              pross: locale.register,
            ),
            SizedBox(height: context.height * 0.05),
            AuthDropdownTextfield(
              icon: Icons.abc,
              label: locale.student,
              items: [''],
              showForgotPassword: false,
              forgotText: '',
            ),
            SizedBox(height: context.height * 0.025),
            AuthDropdownTextfield(
              icon: Icons.cast_for_education,
              label: locale.collage,
              items: [''],
              showForgotPassword: false,
              forgotText: '',
            ),
            SizedBox(height: context.height * 0.025),
            AuthDropdownTextfield(
              icon: Icons.book,
              label: locale.department,
              items: [''],
              showForgotPassword: false,
              forgotText: '',
            ),
            SizedBox(height: context.height * 0.025),
            AuthDropdownTextfield(
              icon: Icons.now_widgets,
              label: locale.current_year,
              items: [''],
              showForgotPassword: false,
              forgotText: '',
            ),
            SizedBox(height: context.height * 0.025),
            AuthDropdownTextfield(
              icon: Icons.no_encryption,
              label: locale.semester,
              items: [''],
              showForgotPassword: false,
              forgotText: '',
            ),
            SizedBox(height: context.height * 0.025),
            AuthDropdownTextfield(
              icon: Icons.toll_rounded,
              label: locale.track,
              items: [''],
              showForgotPassword: false,
              forgotText: '',
            ),
            SizedBox(height: context.height * 0.04),
            CustomElevatedButton(
              onPressed: () {},
              isLoading: false,
              widget: Text(
                locale.next,
                style: context.textTheme.displayMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
