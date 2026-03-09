import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/connect_linkedin_card.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/gob_tab_bar.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/job_alert_card.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/job_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/features/get_jobs/presentation/manager/get_jobs_event.dart';
import 'package:close_gap/features/get_jobs/presentation/manager/get_jobs_state.dart';
import 'package:close_gap/features/get_jobs/presentation/manager/get_jobs_view_model.dart';

class GetJobsScreen extends StatelessWidget {
  const GetJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GetJobsViewModel>()..doIntent(SumbitGetJobsEvent()),
      child: const _GetJobsView(),
    );
  }
}

class _GetJobsView extends StatefulWidget {
  const _GetJobsView();

  @override
  State<_GetJobsView> createState() => _GetJobsViewState();
}

class _GetJobsViewState extends State<_GetJobsView> {
  int _selectedTab = 1;
  bool _alertEnabled = true;
  final Set<int> _savedJobs = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   leading: const BackButton(),
      //   title: Text(l10n.appBarTitle),
      //   actions: [
      //     Icon(Icons.notifications_none, color: theme.appBarTheme.iconTheme?.color),
      //     const SizedBox(width: 12),
      //     Icon(Icons.tune, color: theme.appBarTheme.iconTheme?.color),
      //     const SizedBox(width: 16),
      //   ],
      // ),
      body: Column(
        children: [
          JobsTabBar(
            selectedIndex: _selectedTab,
            onTabSelected: (i) => setState(() => _selectedTab = i),
          ),
          Expanded(
            child: BlocBuilder<GetJobsViewModel, GetJobsState>(
              builder: (context, state) {
                if (state.isLoaddingGetJobs) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.primary,
                    ),
                  );
                }
                if (state.errorMesGetJobs.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 48),
                        const SizedBox(height: 12),
                        Text(state.errorMesGetJobs, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                          ),
                          onPressed: () => context
                              .read<GetJobsViewModel>()
                              .doIntent(SumbitGetJobsEvent()),
                          child: Text(
                            l10n.retryButton,
                            style: theme.textTheme.labelMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                final jobs = state.getJobsList ?? [];
                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    if (jobs.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          l10n.showingResults(jobs.length),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF666666),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ConnectLinkedInCard(onConnect: () {}),
                    const SizedBox(height: 8),
                    JobAlertsCard(
                      isEnabled: _alertEnabled,
                      onToggle: (val) => setState(() => _alertEnabled = val),
                    ),
                    const SizedBox(height: 8),
                    if (jobs.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            l10n.noJobsFound,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      )
                    else
                      ...jobs.asMap().entries.map(
                        (e) => JobItemCard(
                          job: e.value,
                          isSaved: _savedJobs.contains(e.key),
                          onToggleSave: () => setState(() =>
                              _savedJobs.contains(e.key)
                                  ? _savedJobs.remove(e.key)
                                  : _savedJobs.add(e.key)),
                          onApply: () {},
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}