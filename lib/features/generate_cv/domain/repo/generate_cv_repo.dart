import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/generate_cv/domain/entities/generate_cv_request_entity.dart';

abstract class GenerateCvRepo {
  Future<ApiResult<List<int>>> generateCv(
    GenerateCvRequestEntity requestEntity,
  );
}
