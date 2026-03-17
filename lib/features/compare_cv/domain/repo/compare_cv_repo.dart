import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/compare_cv/domain/entities/compare_cv_result_entity.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';

abstract class CompareCvRepo {
  Future<ApiResult<CompareCvResultEntity>> compareCv(LinkedinPostEntity post);
}
