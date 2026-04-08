import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_request_entity.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/use_case/get_advanced_learning_plan_use_case.dart';
import 'package:close_gap/features/learning/advanced_plan/presentation/manager/advanced_learning_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AdvancedLearningPlanViewModel extends Cubit<AdvancedLearningPlanState> {
  final GetAdvancedLearningPlanUseCase _getAdvancedLearningPlanUseCase;

  AdvancedLearningPlanViewModel(this._getAdvancedLearningPlanUseCase)
    : super(const AdvancedLearningPlanState());

  Future<void> getAdvancedLearningPlan(
    AdvancedLearningPlanRequestEntity requestEntity,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _getAdvancedLearningPlanUseCase.call(requestEntity);
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: '',
            learningPlan: result.data,
          ),
        );
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: result.failure.toString(),
          ),
        );
    }
  }
}
