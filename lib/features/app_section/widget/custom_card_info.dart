import 'package:flutter/material.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/extensions/extensions.dart';

class CustomCardInfo extends StatelessWidget {
  const CustomCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var color = context.colorScheme;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(
        Icons.supervised_user_circle_sharp,
        color: color.onSecondary,
      ),
      title: Text(
        'yahya',
        style: theme.bodySmall!.copyWith(
          color: color.onSecondary,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'yahyamo@gmail.com',
        overflow: TextOverflow.ellipsis,
        style: theme.bodySmall!.copyWith(color: color.onSecondary),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.edit_square, color: AppColors.grey),
      ),
    );
  }
}
