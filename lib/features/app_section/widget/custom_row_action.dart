import 'package:flutter/material.dart';
import 'package:close_gap/core/extensions/extensions.dart';

class CustomRowAction extends StatelessWidget {
  const CustomRowAction({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    var color = context.colorScheme;
    var theme = context.textTheme;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ListTile(
        minTileHeight: 30,
        minVerticalPadding: 10,
        title: Text(title, style: theme.displaySmall!.copyWith(fontSize: 14)),
        leading: Icon(icon, color: color.onSecondary),
      ),
    );
  }
}
