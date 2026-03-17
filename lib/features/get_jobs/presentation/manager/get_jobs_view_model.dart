import 'package:close_gap/features/get_jobs/domain/entities/get_jobs_entity.dart';
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
    
    // Mock data instead of API call
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    final mockJobs = [
      const GetJobEntity(
        jobUrl: "https://www.linkedin.com/jobs/view/3456789001",
        jobTitle: "Senior Software Engineer",
        companyUrl: "https://www.google.com",
        companyName: "Google",
        location: "Mountain View, CA",
        isRemote: false,
      ),
      const GetJobEntity(
        jobUrl: "https://www.linkedin.com/jobs/view/3456789002",
        jobTitle: "Flutter Developer",
        companyUrl: "https://www.meta.com",
        companyName: "Meta",
        location: "Cairo, Egypt",
        isRemote: true,
      ),
      const GetJobEntity(
        jobUrl: "https://www.linkedin.com/jobs/view/3456789003",
        jobTitle: "Product Manager",
        companyUrl: "https://www.microsoft.com",
        companyName: "Microsoft",
        location: "Seattle, WA",
        isRemote: false,
      ),
      const GetJobEntity(
        jobUrl: "https://www.linkedin.com/jobs/view/3456789004",
        jobTitle: "UI/UX Designer",
        companyUrl: "https://www.apple.com",
        companyName: "Apple",
        location: "Cupertino, CA",
        isRemote: true,
      ),
    ];
    
    emit(
      state.copyWith(
        isLoaddingGetJobs: false,
        getJobsList: mockJobs,
      ),
    );
    
    // Original API call code (commented out)
    /*
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
    */
  }
}
