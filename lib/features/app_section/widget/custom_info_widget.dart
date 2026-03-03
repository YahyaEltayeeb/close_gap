import 'package:flutter/material.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/features/app_section/widget/custom_card_info.dart';

class CustomInfoWidget extends StatelessWidget {
  const CustomInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var color = context.colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.onSurface,
      ),
      child: CustomCardInfo(),
    );
  }
}
