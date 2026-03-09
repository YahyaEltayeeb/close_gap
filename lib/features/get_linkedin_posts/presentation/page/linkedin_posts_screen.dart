import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/manager/linkedin_posts_event.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/manager/linkedin_posts_state.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/manager/linkedin_posts_view_model.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/widget/linkedin_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinkedinPostsScreen extends StatelessWidget {
  const LinkedinPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<LinkedinPostsViewModel>()..doIntent(SubmitLinkedinPostsEvent()),
      child: const _LinkedinPostsView(),
    );
  }
}

class _LinkedinPostsView extends StatelessWidget {
  const _LinkedinPostsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<LinkedinPostsViewModel, LinkedinPostsState>(
        builder: (context, state) {
          if (state.isLoadingLinkedinPosts) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            );
          }
          if (state.errorMesLinkedinPosts.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    state.errorMesLinkedinPosts,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    onPressed: () => context
                        .read<LinkedinPostsViewModel>()
                        .doIntent(SubmitLinkedinPostsEvent()),
                    child: Text(
                      l10n.retryButton,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          final posts = state.linkedinPostsList ?? [];
          if (posts.isEmpty) {
            return Center(
              child: Text(
                l10n.noPostsFound,
                style: theme.textTheme.bodyMedium,
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return LinkedinPostCard(post: posts[index]);
            },
          );
        },
      ),
    );
  }
}
