import 'package:flutter/material.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/features/app_section/widget/custom_mode_widget.dart';
import 'package:close_gap/features/app_section/widget/custom_row_action.dart';

class CustomSettingWidget extends StatelessWidget {
  const CustomSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    var color = context.colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.onSurface,
      ),
      child: Column(
        children: [
          CustomRowAction(icon: Icons.help_outline, title: locale.help),
          CustomModeWidget(),
          CustomRowAction(icon: Icons.logout_outlined, title: locale.logout)
        ],
      ),
    );
  }
}
