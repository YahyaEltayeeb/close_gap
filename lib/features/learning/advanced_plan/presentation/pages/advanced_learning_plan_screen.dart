import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_entity.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_request_entity.dart';
import 'package:close_gap/features/learning/advanced_plan/presentation/manager/advanced_learning_plan_state.dart';
import 'package:close_gap/features/learning/advanced_plan/presentation/manager/advanced_learning_plan_view_model.dart';
import 'package:close_gap/features/learning/advanced_plan/presentation/widgets/learning_week_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvancedLearningPlanScreen extends StatelessWidget {
  final int trackId;

  const AdvancedLearningPlanScreen({super.key, this.trackId = 1});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<AdvancedLearningPlanViewModel>()
            ..getAdvancedLearningPlan(
              AdvancedLearningPlanRequestEntity(trackId: trackId),
            ),
      child: _AdvancedLearningPlanView(trackId: trackId),
    );
  }
}

class _AdvancedLearningPlanView extends StatelessWidget {
  final int trackId;

  const _AdvancedLearningPlanView({required this.trackId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: SafeArea(
        child: BlocBuilder<AdvancedLearningPlanViewModel, AdvancedLearningPlanState>(
          builder: (context, state) {
            if (state.isLoading && state.learningPlan == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage.isNotEmpty && state.learningPlan == null) {
              return _AdvancedLearningPlanErrorView(
                message: state.errorMessage,
                onRetry: () => _loadPlan(context),
              );
            }

            final learningPlan = state.learningPlan;
            final roadmap = learningPlan?.roadmap ?? const <RoadmapWeekEntity>[];

            return RefreshIndicator(
              onRefresh: () => _loadPlan(context),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                children: [
                  _PlanHeader(
                    totalWeeks: roadmap.length,
                    trackId: learningPlan?.trackId ?? trackId,
                    totalHours: roadmap.fold<int>(
                      0,
                      (sum, item) => sum + item.hours,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (state.errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _InlineErrorBanner(
                        message: state.errorMessage,
                        onRetry: () => _loadPlan(context),
                      ),
                    ),
                  if (roadmap.isEmpty)
                    const _EmptyRoadmapCard()
                  else
                    ...roadmap.map(
                      (week) => LearningWeekCard(
                        week: week,
                        initiallyExpanded: week.week == 1,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _loadPlan(BuildContext context) {
    return context.read<AdvancedLearningPlanViewModel>().getAdvancedLearningPlan(
      AdvancedLearningPlanRequestEntity(trackId: trackId),
    );
  }
}

class _PlanHeader extends StatelessWidget {
  final int totalWeeks;
  final int trackId;
  final int totalHours;

  const _PlanHeader({
    required this.totalWeeks,
    required this.trackId,
    required this.totalHours,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF0A66C2), Color(0xFF3AA0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x220A66C2),
            blurRadius: 20,
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
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Track $trackId',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Advanced learning plan',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Weekly roadmap with courses, required skills, and KPI targets.',
            style: TextStyle(
              color: Color(0xFFE7F3FF),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _HeaderMetric(
                  label: 'Weeks',
                  value: totalWeeks.toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HeaderMetric(
                  label: 'Hours',
                  value: totalHours.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderMetric extends StatelessWidget {
  final String label;
  final String value;

  const _HeaderMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFD7EBFF),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _InlineErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _InlineErrorBanner({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4F4),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFD7D7)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded, color: AppColors.red),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _AdvancedLearningPlanErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _AdvancedLearningPlanErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.auto_stories_rounded,
              size: 56,
              color: AppColors.lightPrimary,
            ),
            const SizedBox(height: 16),
            const Text(
              'Could not load the learning plan.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

class _EmptyRoadmapCard extends StatelessWidget {
  const _EmptyRoadmapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.menu_book_outlined,
            color: AppColors.lightPrimary,
            size: 40,
          ),
          SizedBox(height: 12),
          Text(
            'No roadmap items found for this track yet.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
