import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/core/utils/constants.dart';
import 'package:close_gap/features/get_jobs/domain/entities/get_jobs_entity.dart';
import 'package:close_gap/features/get_jobs/domain/repo/get_jobs_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetJobsUseCase {
  final GetJobsRepo _getJobsRepo;
  final TokenService _tokenService;

  GetJobsUseCase(this._getJobsRepo, this._tokenService);

  Future<ApiResult<List<GetJobEntity>>> call() {
    final savedTrackName = _tokenService.getSavedTrackName();
    return _getJobsRepo.getJobs(
      agentId: AppConstants.jobsAgentId,
      track: savedTrackName,
    );
  }
}
