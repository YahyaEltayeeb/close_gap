import 'package:flutter/material.dart';
import 'package:close_gap/core/l10n/translations/app_localizations.dart';

class JobsTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const JobsTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tabs = [l10n.tabJobPosting, l10n.tabHiringPost];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: const Color(0xFFE0E0E0), width: 1),
        ),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (i) => _TabItem(
            label: tabs[i],
            isSelected: selectedIndex == i,
            onTap: () => onTabSelected(i),
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? const Color(0xFF0A66C2)
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? const Color(0xFF0A66C2)
                    : const Color(0xFF666666),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
