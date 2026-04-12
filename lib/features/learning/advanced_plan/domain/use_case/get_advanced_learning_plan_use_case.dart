import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_entity.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_request_entity.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/repo/advanced_learning_plan_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAdvancedLearningPlanUseCase {
  final AdvancedLearningPlanRepo _advancedLearningPlanRepo;

  GetAdvancedLearningPlanUseCase(this._advancedLearningPlanRepo);

  Future<ApiResult<AdvancedLearningPlanEntity>> call(
    AdvancedLearningPlanRequestEntity requestEntity,
  ) {
    return _advancedLearningPlanRepo.getAdvancedLearningPlan(requestEntity);
  }
}
