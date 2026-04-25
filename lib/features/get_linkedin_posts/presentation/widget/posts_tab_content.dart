import 'package:close_gap/core/l10n/translations/app_localizations.dart';
import 'package:close_gap/features/get_jobs/presentation/widget/app_card.dart';
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
            onRetry: () => context.read<LinkedinPostsViewModel>().doIntent(
              SubmitLinkedinPostsEvent(),
            ),
          );
        }

        final posts = state.linkedinPostsList ?? const [];
        if (posts.isEmpty) {
          return _EmptyPostsState(
            title: l10n.noPostsFound,
            retryLabel: l10n.retryButton,
            onRetry: () => context.read<LinkedinPostsViewModel>().doIntent(
              SubmitLinkedinPostsEvent(),
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

class _EmptyPostsState extends StatelessWidget {
  const _EmptyPostsState({
    required this.title,
    required this.retryLabel,
    required this.onRetry,
  });

  final String title;
  final String retryLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AppCard(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.campaign_outlined,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try refreshing to load the latest hiring posts for your track.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(retryLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
