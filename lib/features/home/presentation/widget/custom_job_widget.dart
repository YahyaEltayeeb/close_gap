import 'package:flutter/material.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/features/home/presentation/widget/custom_card_job.dart';

class CustomJobWidget extends StatelessWidget {
  const CustomJobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    var theme = context.textTheme;
    var color = context.colorScheme;
    return Column(
      children: [
        Row(
          children: [
            Text(
              locale.what_is_new,
              style: theme.displaySmall!.copyWith(color: color.onSecondary),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                locale.sea_all,
                style: theme.displaySmall!.copyWith(
                  fontSize: 11,
                  color: AppColors.darkPrimary,
                ),
              ),
            ),
          ],
        ),
        CustomCardJob(),
      ],
    );
  }
}
