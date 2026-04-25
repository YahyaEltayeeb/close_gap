import 'package:close_gap/features/get_linkedin_posts/data/models/response_linkedin_posts_model_dto.dart';

abstract class LinkedinPostsDataSource {
  Future<LinkedinPostsResponseDto> getLinkedinPostsDataSource({
    required String agentId,
    String? track,
  });
}
