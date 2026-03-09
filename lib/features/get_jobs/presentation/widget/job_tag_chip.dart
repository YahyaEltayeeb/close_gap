import 'package:flutter/material.dart';

class JobTagChip extends StatelessWidget {
  final String label;

  const JobTagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F3FF),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: const Color(0xFF0A66C2),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}