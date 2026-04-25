import 'package:camera/camera.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/features/academic_course/presentation/manager/academic_course_cubit.dart';
import 'package:close_gap/features/academic_course/presentation/pages/academic_course_screen.dart';
import 'package:close_gap/features/app_section/app_section.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_finish_entity.dart';
import 'package:close_gap/features/assessment/presentation/manager/exam/exam_cubit.dart';
import 'package:close_gap/features/assessment/presentation/pages/exam_permission_screen.dart';
import 'package:close_gap/features/assessment/presentation/pages/exam_result_screen.dart';
import 'package:close_gap/features/assessment/presentation/pages/exam_screen.dart';
import 'package:close_gap/features/assessment/presentation/pages/inesrtrutions_screen.dart';
import 'package:close_gap/features/auth/login/presentation/pages/login_screen.dart';
import 'package:close_gap/features/auth/profile/presentation/pages/profile_screen.dart';
import 'package:close_gap/features/certificates/presentation/pages/certificates_screen.dart';
import 'package:close_gap/features/experience/presentation/pages/experience_screen.dart';
import 'package:close_gap/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:close_gap/features/auth/login/domain/entities/user_model_login_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/presentation/pages/register_screen.dart';
import 'package:close_gap/features/auth/register/presentation/pages/stu_register_screen.dart';
import 'package:close_gap/features/get_jobs/presentation/page/get_jobs_screen.dart';
import 'package:close_gap/features/home/presentation/pages/home_screen.dart';
import 'package:close_gap/features/learning/advanced_plan/presentation/pages/advanced_learning_plan_screen.dart';
import 'package:close_gap/features/market_trends/presentation/pages/market_trends_screen.dart';
import 'package:close_gap/features/teacher_home/presentation/pages/teacher_home_screen.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_exam_entity.dart';
import 'package:close_gap/features/teacher_exams/presentation/pages/add_exam_question_screen.dart';
import 'package:close_gap/features/teacher_exams/presentation/pages/create_exam_screen.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_list_item_entity.dart';
import 'package:close_gap/features/teacher_past_exams/presentation/pages/teacher_exam_results_screen.dart';
import 'package:close_gap/features/teacher_past_exams/presentation/pages/teacher_past_exams_screen.dart';
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
      case AppRoutes.teacherHome:
        final user = settings.arguments as UserModelLoginEntity?;
        return MaterialPageRoute(
          builder: (_) => TeacherHomeScreen(
            teacherName: user?.name ?? 'Teacher',
            userRole: user?.role ?? 'teacher',
          ),
        );
      case AppRoutes.createExam:
        return MaterialPageRoute(builder: (_) => const CreateExamScreen());
      case AppRoutes.addExamQuestion:
        final exam = settings.arguments as AcademicExamEntity;
        return MaterialPageRoute(
          builder: (_) => AddExamQuestionScreen(exam: exam),
        );
      case AppRoutes.teacherPastExams:
        return MaterialPageRoute(
          builder: (_) => const TeacherPastExamsScreen(),
        );
      case AppRoutes.teacherExamResults:
        final exam = settings.arguments as TeacherExamListItemEntity;
        return MaterialPageRoute(
          builder: (_) => TeacherExamResultsScreen(exam: exam),
        );

      case AppRoutes.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case AppRoutes.stuRegister:
        final requestEntity = settings.arguments as RegisterRequestEntity;
        return MaterialPageRoute(
          builder: (context) => StuRegisterScreen(requestEntity: requestEntity),
        );
      case AppRoutes.getJobs:
        return MaterialPageRoute(builder: (_) => GetJobsScreen());
      case AppRoutes.instructionspage:
        final args = settings.arguments;
        final tokenService = getIt<TokenService>();
        final trackId = args is Map<String, dynamic>
            ? args['trackId'] as int? ?? tokenService.getSavedTrackId()
            : args as int? ?? tokenService.getSavedTrackId();
        final trackName = args is Map<String, dynamic>
            ? args['trackName'] as String? ?? tokenService.getSavedTrackName()
            : tokenService.getSavedTrackName();
        return MaterialPageRoute(
          builder: (_) =>
              InstructionsScreen(trackId: trackId, trackName: trackName),
        );
      case AppRoutes.permissionpage:
        final args = settings.arguments;
        final tokenService = getIt<TokenService>();
        final trackId = args is Map<String, dynamic>
            ? args['trackId'] as int? ?? tokenService.getSavedTrackId()
            : args as int? ?? tokenService.getSavedTrackId();
        final trackName = args is Map<String, dynamic>
            ? args['trackName'] as String? ?? tokenService.getSavedTrackName()
            : tokenService.getSavedTrackName();
        return MaterialPageRoute(
          builder: (_) =>
              ExamPermissionScreen(trackId: trackId, trackName: trackName),
        );
      case AppRoutes.examScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final controller = args['controller'] as CameraController;
        final trackId = args['trackId'] as int;
        final trackName =
            args['trackName'] as String? ??
            getIt<TokenService>().getSavedTrackName();
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ExamCubit>()..startExam(trackId: trackId),
            child: ExamScreen(
              controller: controller,
              trackId: trackId,
              trackName: trackName,
            ),
          ),
        );
      case AppRoutes.examResult:
        final args = settings.arguments as Map<String, dynamic>;
        final invalidated = args['invalidated'] as bool;
        final result = args['result'] as ExamFinishEntity?;
        final trackId =
            (args['trackId'] as int?) ??
            getIt<TokenService>().getSavedTrackId();
        final trackName =
            args['trackName'] as String? ??
            getIt<TokenService>().getSavedTrackName();
        return MaterialPageRoute(
          builder: (_) => ExamResultScreen(
            invalidated: invalidated,
            result: result,
            trackId: trackId,
            trackName: trackName,
          ),
        );
      case AppRoutes.learningPlan:
        final trackId =
            (settings.arguments as int?) ??
            getIt<TokenService>().getSavedTrackId() ??
            1;
        return MaterialPageRoute(
          builder: (_) => AdvancedLearningPlanScreen(trackId: trackId),
        );
      case AppRoutes.projects:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case AppRoutes.experience:
        return MaterialPageRoute(builder: (_) => const ExperienceScreen());
      case AppRoutes.certificates:
        return MaterialPageRoute(builder: (_) => const CertificatesScreen());
      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case AppRoutes.marketTrends:
        final trackId =
            (settings.arguments as int?) ??
            getIt<TokenService>().getSavedTrackId() ??
            1;
        return MaterialPageRoute(
          builder: (_) => MarketTrendsScreen(trackId: trackId),
        );
      case AppRoutes.academicCourse:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AcademicCourseCubit>(),
            child: const AcademicCoursesScreen(),
          ),
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
