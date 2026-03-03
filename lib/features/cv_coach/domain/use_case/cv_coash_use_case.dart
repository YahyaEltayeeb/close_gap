import 'dart:io';

import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/cv_coach/domain/entities/cv_analysis_entity.dart';
import 'package:close_gap/features/cv_coach/domain/repo/cv_coash_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class CvCoashUseCase {
  final CvCoashRepo _cvCoashRepo;
  CvCoashUseCase(this._cvCoashRepo);
  Future<ApiResult<CvAnalysisEntity>> call(File file) =>
      _cvCoashRepo.cvCoashRepo(file);
}
