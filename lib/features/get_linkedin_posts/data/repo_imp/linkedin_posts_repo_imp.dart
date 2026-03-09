import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/get_linkedin_posts/data/data_source/linkedin_posts_data_source.dart';
import 'package:close_gap/features/get_linkedin_posts/data/mapper/mapper_linkedin_posts_to_entity.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/repo/linkedin_posts_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LinkedinPostsRepo)
class LinkedinPostsRepoImp implements LinkedinPostsRepo {
  final LinkedinPostsDataSource _linkedinPostsDataSource;
  LinkedinPostsRepoImp(this._linkedinPostsDataSource);

  @override
  Future<ApiResult<List<LinkedinPostEntity>>> getLinkedinPosts() async {
    return await safeApiCall(() async {
      var result = await _linkedinPostsDataSource.getLinkedinPostsDataSource();
      return result.posts.map((e) => e.toEntity()).toList();
    });
  }
}
