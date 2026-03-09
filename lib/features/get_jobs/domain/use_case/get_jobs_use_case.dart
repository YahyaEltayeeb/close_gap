import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/get_jobs/domain/entities/get_jobs_entity.dart';
import 'package:close_gap/features/get_jobs/domain/repo/get_jobs_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetJobsUseCase {
  final GetJobsRepo _getJobsRepo;
  GetJobsUseCase(this._getJobsRepo);
  Future<ApiResult<List<GetJobEntity>>> call() => _getJobsRepo.getJobs();
}
