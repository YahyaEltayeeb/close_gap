import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/routing/routing_extensions.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/features/teacher_home/presentation/widgets/teacher_dashboard_card.dart';
import 'package:flutter/material.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({
    super.key,
    required this.teacherName,
    this.userRole = 'teacher',
  });

  final String teacherName;
  final String userRole;

  Future<void> _logout(BuildContext context) async {
    await getIt<TokenService>().deleteToken();
    if (!context.mounted) return;
    await context.pushNamedAndRemoveUntil(
      AppRoutes.login,
      predicate: (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final normalizedRole = userRole.trim().toLowerCase();
    final rawName = teacherName.trim().isEmpty ? 'Reda' : teacherName.trim();
    final displayName =
        normalizedRole == 'teacher' || normalizedRole == 'doctor'
        ? 'DR.$rawName'
        : rawName;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: const Text(
          'Doctor Dashboard',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111111),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout_rounded, color: Color(0xFF111111)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111111),
                    height: 1.15,
                  ),
                  children: [
                    const TextSpan(text: 'Welcome back, '),
                    TextSpan(
                      text: '$displayName!',
                      style: const TextStyle(color: Color(0xFF2D8CFF)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Manage your exams and review submissions.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 28),
              LayoutBuilder(
                builder: (context, constraints) {
                  final contentWidth = constraints.maxWidth > 460
                      ? 460.0
                      : constraints.maxWidth;
                  final cardWidth = (contentWidth - 16) / 2;

                  return Center(
                    child: SizedBox(
                      width: contentWidth,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 20,
                        children: [
                          SizedBox(
                            width: cardWidth,
                            child: TeacherDashboardCard(
                              title: 'Past exams',
                              imageAsset: 'assets/job_test.png',
                              onTap: () {
                                context.pushNamed(AppRoutes.teacherPastExams);
                              },
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: TeacherDashboardCard(
                              title: 'Create exam',
                              icon: Icons.add_task_rounded,
                              outlined: true,
                              onTap: () {
                                context.pushNamed(AppRoutes.createExam);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
