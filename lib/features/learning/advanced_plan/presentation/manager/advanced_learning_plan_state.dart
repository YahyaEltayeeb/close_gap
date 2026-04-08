import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_entity.dart';

class AdvancedLearningPlanState {
  final bool isLoading;
  final String errorMessage;
  final AdvancedLearningPlanEntity? learningPlan;

  const AdvancedLearningPlanState({
    this.isLoading = false,
    this.errorMessage = '',
    this.learningPlan,
  });

  AdvancedLearningPlanState copyWith({
    bool? isLoading,
    String? errorMessage,
    AdvancedLearningPlanEntity? learningPlan,
  }) {
    return AdvancedLearningPlanState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      learningPlan: learningPlan ?? this.learningPlan,
    );
  }
}
