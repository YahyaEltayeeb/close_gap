import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/get_jobs/domain/entities/get_jobs_entity.dart';

abstract class GetJobsRepo {
  Future<ApiResult<List<GetJobEntity>>> getJobs({
    required String agentId,
    String? track,
  });
}
