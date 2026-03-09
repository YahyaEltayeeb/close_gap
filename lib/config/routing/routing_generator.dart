import 'package:close_gap/features/get_jobs/presentation/page/get_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:close_gap/features/app_section/app_section.dart';
import 'package:close_gap/features/auth/register/presentation/pages/register_screen.dart';
import 'package:close_gap/features/auth/register/presentation/pages/stu_register_screen.dart';
import 'package:close_gap/features/home/presentation/pages/home_screen.dart';
import '../../features/auth/login/presentation/pages/login_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRoutes.appSections:
        return MaterialPageRoute(builder: (context) => const AppSection());
       case AppRoutes.home:
       return MaterialPageRoute(builder: (context)=>const HomeScreen()) ;
       
      case AppRoutes.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case AppRoutes.stuRegister:
        return MaterialPageRoute(
          builder: (context) => const StuRegisterScreen(),
        );

      case AppRoutes.getJobs:
      return MaterialPageRoute(builder: (_)=>GetJobsScreen())  ;
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
