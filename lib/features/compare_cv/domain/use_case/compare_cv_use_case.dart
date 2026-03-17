import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/compare_cv/domain/entities/compare_cv_result_entity.dart';
import 'package:close_gap/features/compare_cv/domain/repo/compare_cv_repo.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompareCvUseCase {
  final CompareCvRepo _compareCvRepo;
  CompareCvUseCase(this._compareCvRepo);

  Future<ApiResult<CompareCvResultEntity>> call(LinkedinPostEntity post) =>
      _compareCvRepo.compareCv(post);
}
