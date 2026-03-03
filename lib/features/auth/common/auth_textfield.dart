import 'package:flutter/material.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/extensions/extensions.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController? controller;
  final bool isPassword;
  final bool showForgotPassword;
  final String forgotText;
  final VoidCallback? onForgotTap;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.label,
    required this.icon,
    this.controller,
    this.isPassword = false,
    this.showForgotPassword = false,
    this.forgotText = "Forgot Password?",
    this.onForgotTap,
    required this.validator,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.85,
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscure : false,
            style: context.textTheme.titleMedium,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(color: context.colorScheme.onSurface),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width * 0.03),
                borderSide: BorderSide(
                  color: context.colorScheme.onSurface,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width * 0.03),
                borderSide: BorderSide(
                  color: context.colorScheme.error,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width * 0.03),
                borderSide: const BorderSide(color: AppColors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width * 0.03),
                borderSide: BorderSide(color: AppColors.darkPrimary, width: 1),
              ),
              prefixIcon: Icon(
                widget.icon,
                size: width * 0.06,
                color: context.colorScheme.onSurface,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: context.colorScheme.onSurface,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    )
                  : null,
              contentPadding: EdgeInsets.symmetric(
                vertical: height * 0.015,
                horizontal: width * 0.04,
              ),
            ),
          ),
        ),

        if (widget.showForgotPassword)
          Padding(
            padding: EdgeInsets.only(top: height * 0.006, right: width * 0.02),
            child: GestureDetector(
              onTap: widget.onForgotTap,
              child: Text(
                widget.forgotText,
                style: context.textTheme.bodyLarge,
              ),
            ),
          ),
      ],
    );
  }
}
