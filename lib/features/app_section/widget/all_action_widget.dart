import 'package:flutter/material.dart';
import 'package:close_gap/config/routing/app_routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/features/app_section/widget/custom_row_action.dart';
import 'package:close_gap/features/cv_coach/presentation/pages/cv_coash_page.dart';

class CustomAllActionWidget extends StatelessWidget {
  const CustomAllActionWidget({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  void _selectTab(BuildContext context, int index) {
    Navigator.of(context).pop();
    onDestinationSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    var locale = context.localization;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDCE9F8)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomRowAction(
              title: locale.home,
              icon: Icons.home_outlined,
              selected: currentIndex == 0,
              onTap: () => _selectTab(context, 0),
            ),
            CustomRowAction(
              title: locale.learning_plan,
              icon: Icons.auto_stories_outlined,
              selected: currentIndex == 1,
              onTap: () => _selectTab(context, 1),
            ),
            CustomRowAction(
              title: locale.profile,
              icon: Icons.person_outline,
              selected: currentIndex == 3,
              onTap: () => _selectTab(context, 3),
            ),
            CustomRowAction(
              title: locale.learning_plan,
              icon: FontAwesomeIcons.calendarCheck,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.learningPlan);
              },
            ),
            CustomRowAction(
              title: locale.certificates,
              icon: FontAwesomeIcons.bookOpenReader,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.certificates);
              },
            ),
            CustomRowAction(
              title: 'Academic Courses',
              icon: Icons.school_outlined,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.academicCourse);
              },
            ),
            CustomRowAction(
              title: locale.cV_coach,
              icon: Icons.description_outlined,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CvCoachScreen()),
                );
              },
            ),
            CustomRowAction(
              title: 'Experience',
              icon: Icons.work_history_rounded,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.experience);
              },
            ),
            CustomRowAction(
              title: 'Market Trends',
              icon: Icons.trending_up_rounded,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.marketTrends);
              },
            ),
            CustomRowAction(
              title: 'Projects',
              icon: Icons.folder_open_rounded,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.projects);
              },
            ),
          ],
        ),
      ),
    );
  }
}
