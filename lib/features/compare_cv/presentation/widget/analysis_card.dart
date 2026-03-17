import 'package:close_gap/features/get_jobs/presentation/widget/app_card.dart';
import 'package:flutter/material.dart';

class AnalysisCard extends StatelessWidget {
  final String analysis;
  final bool experienceMatch;
  final bool educationMatch;
  final String? hrEmail;

  const AnalysisCard({
    super.key,
    required this.analysis,
    required this.experienceMatch,
    required this.educationMatch,
    this.hrEmail,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle,
                      color: experienceMatch ? Colors.green : Colors.red,
                      size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Experience: ${experienceMatch ? "Match found" : "No match"}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: experienceMatch ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.school,
                      color: educationMatch ? Colors.green : Colors.red,
                      size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Education: ${educationMatch ? "Match found" : "No match"}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: educationMatch ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.analytics_outlined,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  const Text(
                    'Analysis',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                analysis,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        if (hrEmail != null) ...[
          const SizedBox(height: 16),
          AppCard(
            child: Row(
              children: [
                Icon(Icons.email, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Send your CV to:',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        hrEmail!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
