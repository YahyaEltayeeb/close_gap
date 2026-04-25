import 'package:close_gap/features/generate_cv/common/generate_cv_dimensions.dart';
import 'package:close_gap/features/generate_cv/common/generate_cv_text_style.dart';
import 'package:flutter/material.dart';

class CvStatusHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const CvStatusHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: GenerateCvDimensions.paddingMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GenerateCvTextStyles.screenTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: GenerateCvDimensions.spacingSmall),
          Text(
            subtitle,
            style: GenerateCvTextStyles.screenSubtitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
