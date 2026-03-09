import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/repo/linkedin_posts_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LinkedinPostsUseCase {
  final LinkedinPostsRepo _linkedinPostsRepo;
  LinkedinPostsUseCase(this._linkedinPostsRepo);

  Future<ApiResult<List<LinkedinPostEntity>>> call() =>
      _linkedinPostsRepo.getLinkedinPosts();
}
