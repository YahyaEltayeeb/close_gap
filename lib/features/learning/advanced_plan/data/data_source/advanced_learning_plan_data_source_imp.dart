import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/learning/advanced_plan/data/data_source/advanced_learning_plan_data_source.dart';
import 'package:close_gap/features/learning/advanced_plan/data/models/request/advanced_learning_plan_request_dto.dart';
import 'package:close_gap/features/learning/advanced_plan/data/models/response/advanced_learning_plan_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AdvancedLearningPlanDataSource)
class AdvancedLearningPlanDataSourceImp
    implements AdvancedLearningPlanDataSource {
  final ApiServices _apiServices;

  AdvancedLearningPlanDataSourceImp(this._apiServices);

  @override
  Future<AdvancedLearningPlanResponseDto> getAdvancedLearningPlan(
    AdvancedLearningPlanRequestDto requestDto,
  ) {
    return _apiServices.getAdvancedLearningPlan(requestDto);
  }
}
