import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_request_entity.dart';

sealed class AdvancedLearningPlanEvent {}

class SubmitAdvancedLearningPlanEvent extends AdvancedLearningPlanEvent {
  final AdvancedLearningPlanRequestEntity requestEntity;

  SubmitAdvancedLearningPlanEvent({required this.requestEntity});
}
