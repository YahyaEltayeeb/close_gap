import 'package:flutter/material.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/features/home/presentation/widget/custom_quick_action_card.dart';

class QuickActionWidget extends StatelessWidget {
  const QuickActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    var theme = context.textTheme;
    var color = context.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            locale.quick_actions,
            style: theme.displaySmall!.copyWith(color: color.onSecondary),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomQuickActionCard(title1: locale.learning, title2: locale.plan),
            CustomQuickActionCard(title1: locale.courses, title2: ''),
            CustomQuickActionCard(title1: locale.assessments, title2: ''),
            CustomQuickActionCard(title1: locale.cv, title2: locale.coach),
          ],
        ),
      ],
    );
  }
}
