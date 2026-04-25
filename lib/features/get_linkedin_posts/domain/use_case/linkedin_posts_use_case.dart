import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/core/utils/constants.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/repo/linkedin_posts_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LinkedinPostsUseCase {
  final LinkedinPostsRepo _linkedinPostsRepo;
  final TokenService _tokenService;

  LinkedinPostsUseCase(this._linkedinPostsRepo, this._tokenService);

  Future<ApiResult<List<LinkedinPostEntity>>> call() {
    final savedTrackName = _tokenService.getSavedTrackName();
    return _linkedinPostsRepo.getLinkedinPosts(
      agentId: AppConstants.linkedinPostsAgentId,
      track: savedTrackName,
    );
  }
}
