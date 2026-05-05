import 'package:close_gap/config/routing/routing_generator.dart';
import 'package:close_gap/config/theme/app_theme.dart';
import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/features/app_section/app_section.dart';
import 'package:close_gap/features/auth/login/presentation/pages/login_screen.dart';
import 'package:close_gap/features/teacher_home/presentation/pages/teacher_home_screen.dart';
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
      child: const NexusApp(),
    ),
  );
}

class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

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
          home: const _StartupGate(),
        );
      },
    );
  }
}

class _StartupGate extends StatelessWidget {
  const _StartupGate();

  @override
  Widget build(BuildContext context) {
    final tokenService = getIt<TokenService>();

    return FutureBuilder<String?>(
      future: tokenService.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final hasToken = (snapshot.data ?? '').isNotEmpty;
        if (!hasToken) {
          return const LoginScreen();
        }

        final savedRole = tokenService.getSavedRole();
        final isTeacherView = savedRole == 'teacher' || savedRole == 'doctor';

        if (isTeacherView) {
          return TeacherHomeScreen(
            teacherName: tokenService.getSavedName() ?? 'Teacher',
            userRole: savedRole ?? 'teacher',
          );
        }

        return const AppSection();
      },
    );
  }
}
