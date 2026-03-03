import 'package:flutter/material.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/extensions/extensions.dart';

class CustomQuickActionCard extends StatelessWidget {
  const CustomQuickActionCard({
    super.key,
    required this.title1,
    required this.title2,
  });
  final String title1;
  final String title2;
  @override
  Widget build(BuildContext context) {
    var theme = context.textTheme;
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.darkPrimary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              title1,
              style: theme.headlineSmall!.copyWith(
                color: AppColors.white,
                fontSize: 12,
              ),
            ),
          ),
          ?title2 != ''
              ? Text(
                  title2,
                  style: theme.headlineSmall!.copyWith(
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                )
              : null,
        ],
      ),
    );
  }
}
