import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/learning/advanced_plan/data/data_source/advanced_learning_plan_data_source.dart';
import 'package:close_gap/features/learning/advanced_plan/data/mapper/advanced_learning_plan_mapper.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_entity.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_request_entity.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/repo/advanced_learning_plan_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AdvancedLearningPlanRepo)
class AdvancedLearningPlanRepoImp implements AdvancedLearningPlanRepo {
  final AdvancedLearningPlanDataSource _advancedLearningPlanDataSource;

  AdvancedLearningPlanRepoImp(this._advancedLearningPlanDataSource);

  @override
  Future<ApiResult<AdvancedLearningPlanEntity>> getAdvancedLearningPlan(
    AdvancedLearningPlanRequestEntity requestEntity,
  ) async {
    return safeApiCall(() async {
      final result = await _advancedLearningPlanDataSource
          .getAdvancedLearningPlan(requestEntity.toDto());
      return result.toEntity();
    });
  }
}
