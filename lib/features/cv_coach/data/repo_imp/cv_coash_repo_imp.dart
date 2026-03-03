import 'dart:io';

import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/cv_coach/data/data_source.dart';
import 'package:close_gap/features/cv_coach/data/mapper/cv_coach_mapper.dart';
import 'package:close_gap/features/cv_coach/domain/entities/cv_analysis_entity.dart';
import 'package:close_gap/features/cv_coach/domain/repo/cv_coash_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: CvCoashRepo)
class CvCoashRepoImp implements CvCoashRepo {
  final CvCoashDataSource _cvCoashDataSource;
  CvCoashRepoImp(this._cvCoashDataSource);
  @override
  Future<ApiResult<CvAnalysisEntity>> cvCoashRepo(File file) async {
    return await safeApiCall(() async {
      var result = await _cvCoashDataSource.cvCoashDs(file);
      return result.toEntity();
    });
  }
}
