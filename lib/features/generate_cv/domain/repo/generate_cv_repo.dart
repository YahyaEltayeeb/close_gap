import 'package:close_gap/core/network/api_results.dart';

abstract class GenerateCvRepo {
  Future<ApiResult<List<int>>> generateCv();
}