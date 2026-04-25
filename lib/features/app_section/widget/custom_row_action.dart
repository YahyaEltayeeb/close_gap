import 'package:flutter/material.dart';
import 'package:close_gap/core/extensions/extensions.dart';

class CustomRowAction extends StatelessWidget {
  const CustomRowAction({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.selected = false,
    this.isDestructive = false,
  });
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool selected;
  final bool isDestructive;
  @override
  Widget build(BuildContext context) {
    final theme = context.textTheme;
    const primaryColor = Color(0xFF1F6FD6);
    const textColor = Color(0xFF162033);
    const iconColor = Color(0xFF5E6B7A);
    const destructiveColor = Color(0xFFD92D20);
    final effectiveTextColor = selected
        ? primaryColor
        : isDestructive
        ? destructiveColor
        : textColor;
    final effectiveIconColor = selected
        ? primaryColor
        : isDestructive
        ? destructiveColor
        : iconColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        tileColor: selected ? const Color(0xFFE8F1FF) : Colors.transparent,
        minTileHeight: 34,
        minVerticalPadding: 8,
        onTap: onTap,
        title: Text(
          title,
          style: theme.displaySmall!.copyWith(
            fontSize: 15,
            color: effectiveTextColor,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
        leading: Icon(icon, color: effectiveIconColor),
      ),
    );
  }
}
