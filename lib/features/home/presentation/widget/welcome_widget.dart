import 'package:flutter/material.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/extensions/extensions.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    var theme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(
              children: [
                Text("${locale.hi}, ", style: theme.displayLarge),
                Text(locale.welcome_back, style: theme.displayLarge),
              ],
            ),
          ],
        ),
        Text(
          locale.are_you_ready_to_learn_easier,
          style: theme.displayLarge!.copyWith(
            fontSize: 13,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
