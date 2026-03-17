import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/features/generate_cv/common/generate_cv_dimensions.dart';
import 'package:close_gap/features/generate_cv/common/generate_cv_text_style.dart';
import 'package:flutter/material.dart';
import 'cv_action_button.dart';

class CvReadyCard extends StatelessWidget {
  final String cardTitle;
  final VoidCallback? onDownloadPdf;
  final VoidCallback? onView;
  final VoidCallback? onShare;

  const CvReadyCard({
    super.key,
    this.cardTitle = 'Your CV is ready..!',
    this.onDownloadPdf,
    this.onView,
    this.onShare,
  });

  
  static const double _cardWidth = 350;
  static const double _cardHeight = 180;


  static const double _downloadW = 150;  
  static const double _downloadH = 36;   

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _cardWidth,
      height: _cardHeight,
      margin: const EdgeInsets.symmetric(
        horizontal: GenerateCvDimensions.paddingMedium,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: GenerateCvDimensions.paddingLarge,
        vertical: GenerateCvDimensions.paddingLarge,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(
          GenerateCvDimensions.borderRadiusLarge,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            cardTitle,
            style: GenerateCvTextStyles.cardTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: GenerateCvDimensions.spacingMedium),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(
          GenerateCvDimensions.borderRadiusLarge,
        ),
       
       
      ),
      child: Row(
        children: [
         
          CvActionButton(
            label: 'Download PDF',
            variant: CvButtonVariant.filled,
            onPressed: onDownloadPdf,
            fixedWidth: _downloadW,
            fixedHeight: _downloadH,
          ),
          const SizedBox(width: GenerateCvDimensions.spacingSmall),
          
          Expanded(
            child: CvActionButton(
              label: 'View',
              variant: CvButtonVariant.outline,
              onPressed: onView,
              fixedHeight: _downloadH,
            ),
          ),
          const SizedBox(width: GenerateCvDimensions.spacingSmall),
        
          Expanded(
            child: CvActionButton(
              label: 'Share',
              variant: CvButtonVariant.outline,
              onPressed: onShare,
              fixedHeight: _downloadH,
            ),
          ),
        ],
      ),
    );
  }
}
