import 'package:flutter/material.dart';
import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:close_gap/features/get_jobs/domain/entities/get_jobs_entity.dart';
import 'app_card.dart';
import 'job_tag_chip.dart';

class JobItemCard extends StatelessWidget {
  final GetJobEntity job;
  final bool isSaved;
  final VoidCallback onToggleSave;
  final VoidCallback onApply;

  const JobItemCard({
    super.key,
    required this.job,
    required this.isSaved,
    required this.onToggleSave,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CompanyLogo(url: job.companyUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.jobTitle, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      '${job.companyName}. ${job.location}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(l10n.timeAgo, style: theme.textTheme.labelSmall),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.public,
                          size: 12,
                          color: theme.colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              JobTagChip(
                label: job.isRemote ? l10n.remote : l10n.onSite,
              ),
              const SizedBox(width: 8),
              JobTagChip(label: l10n.fullTime),
              const Spacer(),
              GestureDetector(
                onTap: onToggleSave,
                child: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: isSaved
                      ? Colors.amber
                      : theme.iconTheme.color,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: onApply,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  l10n.applyButton,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  final String url;
  const _CompanyLogo({required this.url});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 52,
        height: 52,
        color: theme.colorScheme.onSurface.withOpacity(0.1),
        child: url.isNotEmpty
            ? Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.business,
                  color: theme.iconTheme.color,
                ),
              )
            : Icon(Icons.business, color: theme.iconTheme.color),
      ),
    );
  }
}