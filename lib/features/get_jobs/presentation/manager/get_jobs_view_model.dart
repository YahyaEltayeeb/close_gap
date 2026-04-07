import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/get_jobs/domain/use_case/get_jobs_use_case.dart';
import 'package:close_gap/features/get_jobs/presentation/manager/get_jobs_event.dart';
import 'package:close_gap/features/get_jobs/presentation/manager/get_jobs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetJobsViewModel extends Cubit<GetJobsState> {
  final GetJobsUseCase _getJobsUseCase;
  GetJobsViewModel(this._getJobsUseCase) : super(GetJobsState());
  void doIntent(GetJobsEvent event) {
    switch (event) {
      case SumbitGetJobsEvent():
      _getJobs();
    }
  }

  void _getJobs() async {
    emit(state.copyWith(isLoaddingGetJobs: true));
    var result = await _getJobsUseCase.call();
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(isLoaddingGetJobs: false, getJobsList: result.data),
        );
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoaddingGetJobs: false,
            errorMesGetJobs: result.failure.toString(),
          ),
        );
    }
  }
}
