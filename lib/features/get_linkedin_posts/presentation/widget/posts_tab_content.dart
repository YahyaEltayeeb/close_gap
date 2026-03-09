import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/error_state_widget.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/manager/linkedin_posts_event.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/manager/linkedin_posts_state.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/manager/linkedin_posts_view_model.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/widget/linkedin_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsTabContent extends StatelessWidget {
  const PostsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocBuilder<LinkedinPostsViewModel, LinkedinPostsState>(
      builder: (context, state) {
        if (state.isLoadingLinkedinPosts) {
          return Center(
            child: CircularProgressIndicator(color: theme.colorScheme.primary),
          );
        }
        if (state.errorMesLinkedinPosts.isNotEmpty) {
          return ErrorStateWidget(
            errorMessage: state.errorMesLinkedinPosts,
            onRetry: () => context
                .read<LinkedinPostsViewModel>()
                .doIntent(SubmitLinkedinPostsEvent()),
          );
        }
        final posts = state.linkedinPostsList ?? [];
        if (posts.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(l10n.noPostsFound, style: theme.textTheme.bodyMedium),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: posts.length,
          itemBuilder: (context, index) => LinkedinPostCard(post: posts[index]),
        );
      },
    );
  }
}
