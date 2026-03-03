import 'dart:io';

import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/cv_coach/domain/entities/cv_analysis_entity.dart';

abstract class CvCoashRepo {
  Future<ApiResult<CvAnalysisEntity>> cvCoashRepo(File file);
}
