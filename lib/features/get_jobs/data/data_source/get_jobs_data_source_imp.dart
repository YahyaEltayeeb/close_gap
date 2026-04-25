import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/get_jobs/data/data_source/get_jobs_data_source.dart';
import 'package:close_gap/features/get_jobs/data/models/response_get_jobs_model_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetJobsDataSource)
class GetJobsDataSourceImp implements GetJobsDataSource {
  final ApiServices _apiServices;
  GetJobsDataSourceImp(this._apiServices);
  @override
  Future<List<GetJobsModelDto>> getJobsDataSource({
    required String agentId,
    String? track,
  }) {
    return _apiServices.getJobs(agentId, track: track);
  }
}
