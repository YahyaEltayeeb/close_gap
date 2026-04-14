import 'package:flutter/material.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/extensions/extensions.dart';

class AuthDropdownTextfield extends StatefulWidget {
  final String label;
  final IconData icon;
  final String? value;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool showForgotPassword;
  final String forgotText;
  final VoidCallback? onForgotTap;

  const AuthDropdownTextfield({
    super.key,
    required this.label,
    required this.icon,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    required this.showForgotPassword,
    required this.forgotText,
    this.onForgotTap,
  });

  @override
  State<AuthDropdownTextfield> createState() => _AuthDropdownTextfieldState();
}

class _AuthDropdownTextfieldState extends State<AuthDropdownTextfield> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant AuthDropdownTextfield oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      selectedValue = widget.value;
    } else if (selectedValue != null && !widget.items.contains(selectedValue)) {
      selectedValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: width * 0.85,
          child: FormField<String>(
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState<String> state) {
              return InputDecorator(
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: BorderSide(
                      color: AppColors.darkPrimary,
                      width: 1,
                    ),
                  ),
                  errorText: state.errorText,
                  prefixIcon: Icon(
                    widget.icon,
                    size: width * 0.06,
                    color: context.colorScheme.onSurface,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: height * 0.015,
                    horizontal: width * 0.04,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedValue,
                    hint: Text(
                      context.localization.select_an_option,
                      style: context.textTheme.titleMedium,
                    ),
                    items: widget.items.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: context.textTheme.titleMedium),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                        state.didChange(value);
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                    },
                  ),
                ),
              );
            },
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
