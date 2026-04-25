import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:close_gap/features/get_jobs/presentation/manager/get_jobs_event.dart';
import 'package:close_gap/features/get_jobs/presentation/manager/get_jobs_state.dart';
import 'package:close_gap/features/get_jobs/presentation/manager/get_jobs_view_model.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/error_state_widget.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/job_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class JobsTabContent extends StatefulWidget {
  const JobsTabContent({super.key});

  @override
  State<JobsTabContent> createState() => _JobsTabContentState();
}

class _JobsTabContentState extends State<JobsTabContent> {
  final Set<int> _savedJobs = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocBuilder<GetJobsViewModel, GetJobsState>(
      builder: (context, state) {
        if (state.isLoaddingGetJobs) {
          return Center(
            child: CircularProgressIndicator(color: theme.colorScheme.primary),
          );
        }
        if (state.errorMesGetJobs.isNotEmpty) {
          return ErrorStateWidget(
            errorMessage: state.errorMesGetJobs,
            onRetry: () =>
                context.read<GetJobsViewModel>().doIntent(SumbitGetJobsEvent()),
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
                  onToggleSave: () => setState(
                    () => _savedJobs.contains(e.key)
                        ? _savedJobs.remove(e.key)
                        : _savedJobs.add(e.key),
                  ),
                  onApply: () => _openUrl(e.value.jobUrl),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
