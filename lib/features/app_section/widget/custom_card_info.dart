import 'package:flutter/material.dart';
import 'package:close_gap/config/theme/colors.dart';

class CustomCardInfo extends StatelessWidget {
  const CustomCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      leading: Icon(
        Icons.supervised_user_circle_sharp,
        color: const Color(0xFF1F6FD6),
        size: 34,
      ),
      title: Text(
        'yahya',
        style: theme.bodySmall!.copyWith(
          color: const Color(0xFF162033),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        'yahyamo@gmail.com',
        overflow: TextOverflow.ellipsis,
        style: theme.bodySmall!.copyWith(
          color: const Color(0xFF6E7B8C),
          fontSize: 13,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.edit_square, color: AppColors.grey),
      ),
    );
  }
}
