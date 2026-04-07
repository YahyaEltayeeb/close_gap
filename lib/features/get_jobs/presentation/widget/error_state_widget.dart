import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 12),
          Text(errorMessage, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
            ),
            onPressed: onRetry,
            child: Text(
              l10n.retryButton,
              style: theme.textTheme.labelMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
