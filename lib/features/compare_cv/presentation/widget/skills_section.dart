import 'package:close_gap/features/get_jobs/presentation/widget/app_card.dart';
import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final List<String> matchedSkills;
  final List<String> unmatchedSkills;

  const SkillsSection({
    super.key,
    required this.matchedSkills,
    required this.unmatchedSkills,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A66C2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Matched Skills',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (unmatchedSkills.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Unmatched Skills',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (matchedSkills.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: matchedSkills.map((skill) {
                return _SkillChip(label: skill, isMatched: true);
              }).toList(),
            ),
            if (unmatchedSkills.isNotEmpty) const SizedBox(height: 12),
          ],
          if (unmatchedSkills.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: unmatchedSkills.map((skill) {
                return _SkillChip(label: skill, isMatched: false);
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final bool isMatched;

  const _SkillChip({required this.label, required this.isMatched});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isMatched ? const Color(0xFF4CAF50) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: isMatched ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
