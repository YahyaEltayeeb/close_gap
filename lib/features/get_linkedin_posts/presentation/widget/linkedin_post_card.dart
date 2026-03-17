import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:close_gap/features/compare_cv/presentation/page/compare_cv_result_screen.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/app_card.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/widget/skill_chip.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkedinPostCard extends StatelessWidget {
  final LinkedinPostEntity post;

  const LinkedinPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.jobTitle, style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(post.companyName, style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.work_outline, size: 14, color: theme.colorScheme.onSurface),
              const SizedBox(width: 4),
              Text(
                post.experienceYears,
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (post.requiredSkills.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: post.requiredSkills.take(5).map((skill) {
                return SkillChip(label: skill);
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            post.jobDescription,
            style: theme.textTheme.bodySmall,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (post.hrEmail != null) ...[
                Icon(Icons.email_outlined, size: 14, color: theme.colorScheme.primary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    post.hrEmail!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              ElevatedButton(
                onPressed: () => _openUrl(post.postUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  l10n.viewPost,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _navigateToCompare(context),
              icon: const Icon(Icons.compare_arrows, size: 18),
              label: const Text('Compare CV'),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                side: BorderSide(color: theme.colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _navigateToCompare(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompareCvResultScreen(post: post),
      ),
    );
  }
}
