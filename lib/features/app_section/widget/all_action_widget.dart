import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/features/app_section/widget/custom_row_action.dart';

class CustomAllActionWidget extends StatelessWidget {
  const CustomAllActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var color = context.colorScheme;
    var locale = context.localization;
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.onSurface,
      ),
      child: Column(
        children: [
          CustomRowAction(
            title: locale.assessments,
            icon: Icons.menu_book_rounded,
          ),
          CustomRowAction(
            title: locale.learning_plan,
            icon: FontAwesomeIcons.calendarCheck,
          ),
          CustomRowAction(
            title: locale.academic_courses,
            icon: Icons.computer_rounded,
          ),
          CustomRowAction(title: locale.courses, icon: Icons.book_outlined),
          CustomRowAction(
            title: locale.cV_coach,
            icon: Icons.note_alt_outlined,
          ),
          CustomRowAction(
            title: locale.certificates,
            icon: FontAwesomeIcons.bookOpenReader,
          ),
          CustomRowAction(
            title: locale.job_description,
            icon: Icons.work_outline_rounded,
          ),
          CustomRowAction(
            title: locale.linked_in_jobs,
            icon: FontAwesomeIcons.linkedin,
          ),
          CustomRowAction(title: locale.settings, icon: Icons.settings),
        ],
      ),
    );
  }
}
