import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';

abstract class LinkedinPostsRepo {
  Future<ApiResult<List<LinkedinPostEntity>>> getLinkedinPosts();
}
