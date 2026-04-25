import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/features/chatbot/presentation/manager/chatbot_cubit.dart';
import 'package:close_gap/features/get_jobs/presentation/page/get_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/features/app_section/widget/custom_drawer.dart';
import 'package:close_gap/features/auth/profile/presentation/pages/profile_screen.dart';
import 'package:close_gap/features/home/presentation/pages/home_screen.dart';
import 'package:close_gap/features/home/presentation/widget/home_chatbot_sheet.dart';
import 'package:close_gap/features/learning/advanced_plan/presentation/pages/advanced_learning_plan_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  final PageStorageBucket _bucket = PageStorageBucket();

  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const AdvancedLearningPlanScreen();
      case 2:
        return const GetJobsScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    return Scaffold(
      drawer: CustomDrawer(
        currentIndex: _currentIndex,
        onDestinationSelected: _onTabSelected,
      ),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.notifications),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: PageStorage(bucket: _bucket, child: _buildCurrentPage()),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  showDragHandle: false,
                  backgroundColor: context.colorScheme.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  builder: (_) => BlocProvider(
                    create: (_) => getIt<ChatbotCubit>(),
                    child: const HomeChatbotSheet(),
                  ),
                );
              },
              backgroundColor: AppColors.lightPrimary,
              foregroundColor: AppColors.white,
              elevation: 3,
              icon: const Icon(Icons.smart_toy_outlined),
              label: const Text('Chatbot'),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        enableFeedback: false,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabSelected,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: locale.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.auto_stories_outlined),
            label: 'Learning Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'LinkedIn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: locale.profile,
          ),
        ],
      ),
    );
  }
}
