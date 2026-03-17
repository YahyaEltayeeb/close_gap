import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/compare_cv/data/data_source/compare_cv_data_source.dart';
import 'package:close_gap/features/compare_cv/data/model/mapper/compare_cv_mapper.dart';
import 'package:close_gap/features/compare_cv/data/model/request/compare_cv_request_dto.dart';
import 'package:close_gap/features/compare_cv/domain/entities/compare_cv_result_entity.dart';
import 'package:close_gap/features/compare_cv/domain/repo/compare_cv_repo.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CompareCvRepo)
class CompareCvRepoImp implements CompareCvRepo {
  final CompareCvDataSource _compareCvDataSource;
  CompareCvRepoImp(this._compareCvDataSource);

  @override
  Future<ApiResult<CompareCvResultEntity>> compareCv(
      LinkedinPostEntity post) async {
    return await safeApiCall(() async {
      final request = CompareCvRequestDto(
        jobDescription: JobDescriptionDto(
          jobTitle: post.jobTitle,
          companyName: post.companyName,
          requiredSkills: post.requiredSkills,
          preferredSkills: post.preferredSkills,
          experienceYears: post.experienceYears,
          educationRequired: post.educationRequired,
          languagesRequired: post.languagesRequired,
          jobDescription: post.jobDescription,
          postUrl: post.postUrl,
          hrEmail: post.hrEmail,
        ),
      );
      var result = await _compareCvDataSource.compareCv(request);
      return result.toEntity();
    });
  }
}
