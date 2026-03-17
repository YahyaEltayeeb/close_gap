import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/features/compare_cv/presentation/manager/compare_cv_event.dart';
import 'package:close_gap/features/compare_cv/presentation/manager/compare_cv_state.dart';
import 'package:close_gap/features/compare_cv/presentation/manager/compare_cv_view_model.dart';
import 'package:close_gap/features/compare_cv/presentation/widget/analysis_card.dart';
import 'package:close_gap/features/compare_cv/presentation/widget/match_score_widget.dart';
import 'package:close_gap/features/compare_cv/presentation/widget/skills_section.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompareCvResultScreen extends StatelessWidget {
  final LinkedinPostEntity post;

  const CompareCvResultScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<CompareCvViewModel>()..doIntent(SubmitCompareCvEvent(post)),
      child: const _CompareCvResultView(),
    );
  }
}

class _CompareCvResultView extends StatelessWidget {
  const _CompareCvResultView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Job Description Analysis'),
      ),
      body: BlocBuilder<CompareCvViewModel, CompareCvState>(
        builder: (context, state) {
          if (state.isLoadingCompareCv) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            );
          }
          if (state.errorMesCompareCv.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    state.errorMesCompareCv,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          final result = state.compareCvResult;
          if (result == null) {
            return const Center(child: Text('No data found'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                MatchScoreWidget(score: result.score),
                const SizedBox(height: 16),
                SkillsSection(
                  matchedSkills: result.matchedSkills,
                  unmatchedSkills: result.unmatchedSkills,
                ),
                const SizedBox(height: 16),
                AnalysisCard(
                  analysis: result.analysis,
                  experienceMatch: result.experienceMatch,
                  educationMatch: result.educationMatch,
                  hrEmail: result.hrEmail,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
