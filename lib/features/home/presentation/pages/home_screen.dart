import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/helpers/spacing.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/features/cv_coach/presentation/pages/cv_coash_page.dart';
import 'package:close_gap/features/home/presentation/widget/home_feature_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenService = getIt<TokenService>();
    final name = tokenService.getSavedName() ?? 'Learner';
    final email = tokenService.getSavedEmail() ?? '';
    final trackName = tokenService.getSavedTrackName();
    final year = tokenService.getSavedYear();
    final semester = tokenService.getSavedCurrentSemester();
    final pathType = tokenService.getSavedPathType();
    final faculty = tokenService.getSavedFacultyName();
    final department = tokenService.getSavedDepartmentName();

    final primaryActions = <_HomeActionItem>[
      _HomeActionItem(
        title: 'Learning Plan',
        subtitle: 'Follow your roadmap week by week.',
        icon: Icons.auto_stories_rounded,
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.learningPlan),
      ),
      _HomeActionItem(
        title: 'Jobs & Posts',
        subtitle: 'Browse jobs and LinkedIn content in one place.',
        icon: Icons.work_outline_rounded,
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.getJobs),
      ),
      _HomeActionItem(
        title: 'Market Trends',
        subtitle: 'See what skills are growing in demand.',
        icon: Icons.trending_up_rounded,
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.marketTrends),
      ),
      _HomeActionItem(
        title: 'Profile',
        subtitle: 'Review and update your academic profile.',
        icon: Icons.person_outline_rounded,
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.projects),
      ),
    ];

    final secondaryActions = <_HomeActionItem>[
      _HomeActionItem(
        title: 'Certificates',
        subtitle: 'Track your completed certificates.',
        icon: Icons.workspace_premium_outlined,
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.certificates),
      ),
      _HomeActionItem(
        title: 'Experience',
        subtitle: 'Keep your practical experience up to date.',
        icon: Icons.work_history_rounded,
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.experience),
      ),
      _HomeActionItem(
        title: 'Notifications',
        subtitle: 'Catch up on the latest important updates.',
        icon: Icons.notifications_none_rounded,
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.notifications),
      ),
      _HomeActionItem(
        title: 'CV Coach',
        subtitle: 'Upload your CV and get AI feedback.',
        icon: Icons.description_outlined,
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const CvCoachScreen()));
        },
      ),
    ];

    final overviewItems = <_OverviewItem>[
      _OverviewItem(
        label: 'Track',
        value: trackName?.trim().isNotEmpty == true ? trackName! : 'Not set',
        icon: Icons.hub_outlined,
      ),
      _OverviewItem(
        label: 'Academic Year',
        value: year != null ? 'Year $year' : 'Unknown',
        icon: Icons.calendar_today_outlined,
      ),
      _OverviewItem(
        label: 'Semester',
        value: semester != null ? 'Semester $semester' : 'Unknown',
        icon: Icons.timelapse_outlined,
      ),
      _OverviewItem(
        label: faculty?.trim().isNotEmpty == true ? 'Faculty' : 'Path Type',
        value: faculty?.trim().isNotEmpty == true
            ? faculty!
            : pathType?.trim().isNotEmpty == true
            ? pathType!
            : 'Not set',
        icon: faculty?.trim().isNotEmpty == true
            ? Icons.account_balance_outlined
            : Icons.route_outlined,
      ),
    ];

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          // The home content is driven by saved local session data,
          // so rebuilding the tree is enough for a lightweight refresh.
          await Future<void>.delayed(const Duration(milliseconds: 450));
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
          children: [
            _HomeHeroCard(
              name: name,
              email: email,
              trackName: trackName,
              faculty: faculty,
              department: department,
            ),
            verticalSpace(18),
            _SectionHeader(
              title: 'Overview',
              subtitle: 'Your saved academic context at a glance.',
            ),
            verticalSpace(12),
            _OverviewGrid(items: overviewItems),
            verticalSpace(20),
            _SectionHeader(
              title: 'Main actions',
              subtitle: 'Start with the features you are most likely to need.',
            ),
            verticalSpace(12),
            _FeatureGrid(actions: primaryActions),
            verticalSpace(20),
            _SectionHeader(
              title: 'More tools',
              subtitle: 'Everything else stays one tap away.',
            ),
            verticalSpace(12),
            _FeatureGrid(actions: secondaryActions),
            verticalSpace(20),
            _InsightCard(trackName: trackName),
          ],
        ),
      ),
    );
  }
}

class _HomeHeroCard extends StatelessWidget {
  const _HomeHeroCard({
    required this.name,
    required this.email,
    required this.trackName,
    required this.faculty,
    required this.department,
  });

  final String name;
  final String email;
  final String? trackName;
  final String? faculty;
  final String? department;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF0A66C2), Color(0xFF58A6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x220A66C2),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'Student Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          verticalSpace(16),
          Text(
            'Welcome back, $name',
            style: textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          verticalSpace(8),
          Text(
            trackName?.trim().isNotEmpty == true
                ? 'You are currently following the $trackName track. Let\'s keep the momentum going.'
                : 'Complete your profile setup to unlock a more personalized learning experience.',
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFE9F4FF),
              height: 1.45,
            ),
          ),
          if (email.trim().isNotEmpty) ...[
            verticalSpace(14),
            _HeroInfoChip(icon: Icons.alternate_email_rounded, label: email),
          ],
          if ((faculty?.trim().isNotEmpty ?? false) ||
              (department?.trim().isNotEmpty ?? false)) ...[
            verticalSpace(10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (faculty?.trim().isNotEmpty ?? false)
                  _HeroInfoChip(
                    icon: Icons.account_balance_outlined,
                    label: faculty!,
                  ),
                if (department?.trim().isNotEmpty ?? false)
                  _HeroInfoChip(
                    icon: Icons.apartment_outlined,
                    label: department!,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _HeroInfoChip extends StatelessWidget {
  const _HeroInfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          horizontalSpace(8),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.displaySmall?.copyWith(
            color: context.colorScheme.onSecondary,
          ),
        ),
        verticalSpace(4),
        Text(
          subtitle,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _OverviewGrid extends StatelessWidget {
  const _OverviewGrid({required this.items});

  final List<_OverviewItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useTwoColumns = constraints.maxWidth >= 360;
        final itemWidth = useTwoColumns
            ? (constraints.maxWidth - 12) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: items
              .map(
                (item) => SizedBox(
                  width: itemWidth,
                  child: _OverviewCard(item: item),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.item});

  final _OverviewItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFDCE9F8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: AppColors.lightPrimary),
          ),
          verticalSpace(14),
          Text(
            item.label,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
          verticalSpace(4),
          Text(
            item.value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid({required this.actions});

  final List<_HomeActionItem> actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 700
            ? 3
            : constraints.maxWidth >= 420
            ? 2
            : 1;
        final totalSpacing = 12.0 * (columns - 1);
        final itemWidth = (constraints.maxWidth - totalSpacing) / columns;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: actions
              .map(
                (action) => SizedBox(
                  width: itemWidth,
                  child: HomeFeatureCard(
                    title: action.title,
                    subtitle: action.subtitle,
                    icon: action.icon,
                    onTap: action.onTap,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({this.trackName});

  final String? trackName;

  @override
  Widget build(BuildContext context) {
    final hasTrack = trackName?.trim().isNotEmpty == true;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFDCE9F8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.lightbulb_outline_rounded,
              color: AppColors.lightPrimary,
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasTrack ? 'Recommended next step' : 'Complete your setup',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                verticalSpace(6),
                Text(
                  hasTrack
                      ? 'Open Market Trends and Learning Plan to align your weekly study with what employers currently need for $trackName.'
                      : 'Your home screen already works, but adding track details in your profile will make recommendations much more useful.',
                  style: context.textTheme.bodyMedium?.copyWith(height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeActionItem {
  const _HomeActionItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
}

class _OverviewItem {
  const _OverviewItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}
