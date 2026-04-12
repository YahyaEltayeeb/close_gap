import 'package:close_gap/config/theme/colors.dart';
import 'package:flutter/material.dart';

class LearningLinkRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool enabled;

  const LearningLinkRow({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = enabled
        ? AppColors.lightPrimary
        : AppColors.darkTextSecondary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFD),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE3EAF3)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: enabled
                    ? AppColors.lightPrimary.withOpacity(0.10)
                    : const Color(0xFFF0F1F4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.play_lesson_rounded,
                size: 20,
                color: enabled
                    ? AppColors.lightPrimary
                    : AppColors.darkTextSecondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: enabled ? onTap : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  backgroundColor: buttonColor,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: buttonColor,
                  disabledForegroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                child: Text(
                  enabled ? 'Open' : 'Unavailable',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
