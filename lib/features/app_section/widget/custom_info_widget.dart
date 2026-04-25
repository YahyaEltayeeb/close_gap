import 'package:flutter/material.dart';
import 'package:close_gap/features/app_section/widget/custom_card_info.dart';

class CustomInfoWidget extends StatelessWidget {
  const CustomInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDCE9F8)),
      ),
      child: const CustomCardInfo(),
    );
  }
}
