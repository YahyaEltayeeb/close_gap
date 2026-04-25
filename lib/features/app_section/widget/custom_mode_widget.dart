import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/general_cubit/general_state.dart';
import 'package:close_gap/core/general_cubit/local_cubit.dart';

class CustomModeWidget extends StatelessWidget {
  const CustomModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.textTheme;
    final locale = context.localization;

    return BlocBuilder<LocaleThemeCubit, LocaleThemeState>(
      builder: (context, state) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          leading: Icon(
            state.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: const Color(0xFF5E6B7A),
          ),
          title: Text(
            state.isDark ? locale.light_mode : locale.dark_mode,
            style: theme.displaySmall!.copyWith(
              fontSize: 15,
              color: const Color(0xFF162033),
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Switch(
            value: state.isDark,
            onChanged: (_) {
              context.read<LocaleThemeCubit>().toggleTheme();
            },
          ),
        );
      },
    );
  }
}
