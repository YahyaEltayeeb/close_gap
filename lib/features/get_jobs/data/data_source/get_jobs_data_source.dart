import 'package:close_gap/features/get_jobs/data/models/response_get_jobs_model_dto.dart';

abstract class GetJobsDataSource {
  Future<List<GetJobsModelDto>> getJobsDataSource();
}
