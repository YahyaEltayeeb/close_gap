import 'package:flutter/material.dart';
import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'app_card.dart';

class ConnectLinkedInCard extends StatelessWidget {
  final VoidCallback onConnect;

  const ConnectLinkedInCard({super.key, required this.onConnect});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.connectTitle, style: theme.textTheme.displaySmall),
          const SizedBox(height: 4),
          Text(l10n.connectSubtitle, style: theme.textTheme.bodySmall),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: onConnect,
              icon: const Icon(Icons.link, size: 18, color: Colors.white),
              label: Text(
                l10n.connectButton,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}