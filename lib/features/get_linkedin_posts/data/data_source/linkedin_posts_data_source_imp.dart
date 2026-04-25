import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/get_linkedin_posts/data/data_source/linkedin_posts_data_source.dart';
import 'package:close_gap/features/get_linkedin_posts/data/models/response_linkedin_posts_model_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LinkedinPostsDataSource)
class LinkedinPostsDataSourceImp implements LinkedinPostsDataSource {
  final ApiServices _apiServices;
  LinkedinPostsDataSourceImp(this._apiServices);

  @override
  Future<LinkedinPostsResponseDto> getLinkedinPostsDataSource({
    required String agentId,
    String? track,
  }) {
    return _apiServices.getLinkedinPosts(agentId, track: track);
  }
}
