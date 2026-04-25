import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/features/generate_cv/common/generate_cv_dimensions.dart';
import 'package:close_gap/features/generate_cv/common/generate_cv_text_style.dart';
import 'package:flutter/material.dart';

enum CvButtonVariant { filled, outline }

class CvActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final CvButtonVariant variant;
  final double? fixedWidth;
  final double? fixedHeight;

  const CvActionButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = CvButtonVariant.filled,
    this.fixedWidth,
    this.fixedHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          fixedWidth ??
          (variant == CvButtonVariant.filled ? double.infinity : null),
      height: fixedHeight ?? GenerateCvDimensions.buttonHeight,
      child: variant == CvButtonVariant.filled
          ? _buildFilledButton()
          : _buildOutlineButton(),
    );
  }

  Widget _buildFilledButton() {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.primary,
        disabledForegroundColor: Colors.white,
        minimumSize: Size(
          fixedWidth ?? 0,
          fixedHeight ?? GenerateCvDimensions.buttonHeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            GenerateCvDimensions.borderRadiusButton,
          ),
        ),
        elevation: 3,
        shadowColor: AppColors.primary.withOpacity(0.45),
      ),

      child: Text(
        label,
        style: GenerateCvTextStyles.filledButtonLabel,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildOutlineButton() {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.cardBackground, // نفس لون الكارد
        foregroundColor: AppColors.primary,
        minimumSize: Size(
          fixedWidth ?? GenerateCvDimensions.outlineButtonMinWidth,
          fixedHeight ?? GenerateCvDimensions.buttonHeight,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            GenerateCvDimensions.borderRadiusButton,
          ),
        ),
        side: const BorderSide(color: AppColors.border, width: 1.2),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.10),
      ),
      child: Text(label, style: GenerateCvTextStyles.outlineButtonLabel),
    );
  }
}
