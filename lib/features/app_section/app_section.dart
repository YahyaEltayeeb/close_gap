import 'package:close_gap/features/get_jobs/presentation/page/get_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/features/app_section/widget/custom_drawer.dart';
import 'package:close_gap/features/auth/profile/presentation/pages/profile_screen.dart';
import 'package:close_gap/features/cv_coach/presentation/pages/cv_coash_page.dart';
import 'package:close_gap/features/home/presentation/pages/home_screen.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  final PageStorageBucket _bucket = PageStorageBucket();

  int _currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    CvCoachScreen(),
    GetJobsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: PageStorage(bucket: _bucket, child: pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        enableFeedback: false,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: locale.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.description_outlined),
            label: 'CV Coach',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: locale.jobs,
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
