import 'package:flutter/material.dart';
import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/routing/routing_extensions.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/features/app_section/widget/custom_row_action.dart';

class CustomSettingWidget extends StatelessWidget {
  const CustomSettingWidget({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Confirm logout'),
          content: const Text(
            'Are you sure you want to log out from this account?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFD92D20),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) return;

    await getIt<TokenService>().deleteToken();
    if (!context.mounted) return;
    await context.pushNamedAndRemoveUntil(
      AppRoutes.login,
      predicate: (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDCE9F8)),
      ),
      child: Column(
        children: [
          CustomRowAction(
            icon: Icons.logout_outlined,
            title: locale.logout,
            isDestructive: true,
            onTap: () => _handleLogout(context),
          ),
        ],
      ),
    );
  }
}
