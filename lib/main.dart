import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/routing/routing_generator.dart';
import 'package:close_gap/config/theme/app_theme.dart';
import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/general_cubit/general_state.dart';
import 'package:close_gap/core/general_cubit/local_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    BlocProvider(
      create: (context) => getIt<LocaleThemeCubit>(),
      child: const CloseGap(),
    ),
  );
}

class CloseGap extends StatelessWidget {
  const CloseGap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleThemeCubit, LocaleThemeState>(
      builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.locale,
          theme: state.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: AppRoutes.register,
         
        );
      },
    );
  }
}
