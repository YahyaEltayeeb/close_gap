import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/features/get_jobs/presentation/manager/get_jobs_event.dart';
import 'package:close_gap/features/get_jobs/presentation/manager/get_jobs_view_model.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/gob_tab_bar.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/jobs_tab_content.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/manager/linkedin_posts_event.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/manager/linkedin_posts_view_model.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/widget/posts_tab_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetJobsScreen extends StatelessWidget {
  const GetJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<GetJobsViewModel>()..doIntent(SumbitGetJobsEvent()),
        ),
        BlocProvider(
          create: (_) => getIt<LinkedinPostsViewModel>()
            ..doIntent(SubmitLinkedinPostsEvent()),
        ),
      ],
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
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          JobsTabBar(
            selectedIndex: _selectedTab,
            onTabSelected: (i) => setState(() => _selectedTab = i),
          ),
          Expanded(
            child: _selectedTab == 0
                ? const JobsTabContent()
                : const PostsTabContent(),
          ),
        ],
      ),
    );
  }
}
