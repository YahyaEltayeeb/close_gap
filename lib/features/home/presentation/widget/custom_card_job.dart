import 'package:flutter/material.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/utils/assets.dart';

class CustomCardJob extends StatelessWidget {
  const CustomCardJob({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = context.textTheme;
    var color = context.colorScheme;
    var locale = context.localization;
    return Card(
      color: color.surface,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(AppAssets.jobTest),
              // static text for test only
              title: Text('Junior UI/UX Designer', style: theme.displaySmall),
              // static text for test only
              subtitle: Text(
                'description',
                style: theme.headlineMedium!.copyWith(
                  fontSize: 12,
                  color: AppColors.grey,
                ),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    locale.apply,
                    style: theme.headlineMedium!.copyWith(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
