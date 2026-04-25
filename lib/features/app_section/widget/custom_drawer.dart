import 'package:flutter/material.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/helpers/spacing.dart';
import 'package:close_gap/features/app_section/widget/all_action_widget.dart';
import 'package:close_gap/features/app_section/widget/custom_setting_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Drawer(
          width: context.width * .75,
          backgroundColor: const Color(0xFFF7FAFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              children: [
                verticalSpace(4),
                const SizedBox(height: 12),
                Expanded(
                  child: CustomAllActionWidget(
                    currentIndex: currentIndex,
                    onDestinationSelected: onDestinationSelected,
                  ),
                ),
                const SizedBox(height: 12),
                const CustomSettingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
