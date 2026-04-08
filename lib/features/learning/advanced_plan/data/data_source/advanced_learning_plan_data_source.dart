import 'package:close_gap/features/learning/advanced_plan/data/models/request/advanced_learning_plan_request_dto.dart';
import 'package:close_gap/features/learning/advanced_plan/data/models/response/advanced_learning_plan_response_dto.dart';

abstract class AdvancedLearningPlanDataSource {
  Future<AdvancedLearningPlanResponseDto> getAdvancedLearningPlan(
    AdvancedLearningPlanRequestDto requestDto,
  );
}
