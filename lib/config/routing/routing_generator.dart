import 'package:camera/camera.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/features/app_section/app_section.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_finish_entity.dart';
import 'package:close_gap/features/assessment/presentation/manager/exam/exam_cubit.dart';
import 'package:close_gap/features/assessment/presentation/pages/exam_permission_screen.dart';
import 'package:close_gap/features/assessment/presentation/pages/exam_result_screen.dart';
import 'package:close_gap/features/assessment/presentation/pages/exam_screen.dart';
import 'package:close_gap/features/assessment/presentation/pages/inesrtrutions_screen.dart';
import 'package:close_gap/features/auth/login/presentation/pages/login_screen.dart';
import 'package:close_gap/features/auth/register/presentation/pages/register_screen.dart';
import 'package:close_gap/features/auth/register/presentation/pages/stu_register_screen.dart';
import 'package:close_gap/features/get_jobs/presentation/page/get_jobs_screen.dart';
import 'package:close_gap/features/home/presentation/pages/home_screen.dart';
import 'package:close_gap/features/learning/advanced_plan/presentation/pages/advanced_learning_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.appSections:
        return MaterialPageRoute(builder: (_) => const AppSection());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.stuRegister:
        return MaterialPageRoute(builder: (_) => const StuRegisterScreen());
      case AppRoutes.getJobs:
        return MaterialPageRoute(builder: (_) => GetJobsScreen());
      case AppRoutes.instructionspage:
        final trackId = (settings.arguments as int?) ?? 1;
        return MaterialPageRoute(
          builder: (_) => InstructionsScreen(trackId: trackId),
        );
      case AppRoutes.permissionpage:
        final trackId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => ExamPermissionScreen(trackId: trackId),
        );
      case AppRoutes.examScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final controller = args['controller'] as CameraController;
        final trackId = args['trackId'] as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ExamCubit>()..startExam(trackId: trackId),
            child: ExamScreen(controller: controller, examId: trackId),
          ),
        );
      case AppRoutes.examResult:
        final args = settings.arguments as Map<String, dynamic>;
        final invalidated = args['invalidated'] as bool;
        final result = args['result'] as ExamFinishEntity?;
        final trackId = (args['trackId'] as int?) ?? 1;
        return MaterialPageRoute(
          builder: (_) => ExamResultScreen(
            invalidated: invalidated,
            result: result,
            trackId: trackId,
          ),
        );
      case AppRoutes.learningPlan:
        final trackId = (settings.arguments as int?) ?? 1;
        return MaterialPageRoute(
          builder: (_) => AdvancedLearningPlanScreen(trackId: trackId),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
