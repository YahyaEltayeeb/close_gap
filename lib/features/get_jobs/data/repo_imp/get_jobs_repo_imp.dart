import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/get_jobs/data/data_source/get_jobs_data_source.dart';
import 'package:close_gap/features/get_jobs/data/mapper/mapper_get_jobs_to_entity.dart';
import 'package:close_gap/features/get_jobs/domain/entities/get_jobs_entity.dart';
import 'package:close_gap/features/get_jobs/domain/repo/get_jobs_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetJobsRepo)
class GetJobsRepoImp implements GetJobsRepo {
  final GetJobsDataSource _getJobsDataSource;
  GetJobsRepoImp(this._getJobsDataSource);
  @override
  Future<ApiResult<List<GetJobEntity>>> getJobs() async {
    return await safeApiCall(() async {
      var result = await _getJobsDataSource.getJobsDataSource();
      return result.map((e) => e.toEntity()).toList();
    });
  }
}
