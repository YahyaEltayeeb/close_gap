import 'package:flutter/material.dart';
import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'app_card.dart';

class JobAlertsCard extends StatelessWidget {
  final bool isEnabled;
  final ValueChanged<bool> onToggle;

  const JobAlertsCard({
    super.key,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.notifications_active_outlined,
              color: theme.colorScheme.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(l10n.alertLabel, style: theme.textTheme.titleSmall),
          ),
          Switch(
            value: isEnabled,
            onChanged: onToggle,
            activeColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}