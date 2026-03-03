import 'package:flutter/material.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/extensions/extensions.dart';

class LinearProgressWidget extends StatelessWidget {
  const LinearProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = context.textTheme;
    var locale=context.localization;
    return SizedBox(
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Row(
                children: [
                  Text('AI Track', style: theme.displaySmall),
                  Spacer(),
                  Text('65%'),
                ],
              ),

              LinearProgressIndicator(
                value: 0.65,
                minHeight: 6,
                backgroundColor: AppColors.grey,
                color: AppColors.darkPrimary,
              ),
              Text(
                locale.keep_up_the_great_work,
                style: theme.headlineMedium!.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
