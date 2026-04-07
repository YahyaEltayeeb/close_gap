import 'package:close_gap/features/get_jobs/domain/entities/get_jobs_entity.dart';

class GetJobsState {
  bool isLoaddingGetJobs;
  String errorMesGetJobs;
  List<GetJobEntity>? getJobsList;
  GetJobsState({
    this.getJobsList,
    this.errorMesGetJobs = '',

    this.isLoaddingGetJobs = false,
  });
  GetJobsState copyWith({
    List<GetJobEntity>? getJobsList,
    bool? isLoaddingGetJobs,
    String? errorMesGetJobs,
  
  }) {
    return GetJobsState(
      isLoaddingGetJobs: isLoaddingGetJobs ?? this.isLoaddingGetJobs,
      errorMesGetJobs: errorMesGetJobs ?? this.errorMesGetJobs,
      getJobsList: getJobsList ?? this.getJobsList,
    );
  }
}
