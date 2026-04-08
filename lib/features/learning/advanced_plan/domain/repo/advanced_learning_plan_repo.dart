import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_entity.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_request_entity.dart';

abstract class AdvancedLearningPlanRepo {
  Future<ApiResult<AdvancedLearningPlanEntity>> getAdvancedLearningPlan(
    AdvancedLearningPlanRequestEntity requestEntity,
  );
}
