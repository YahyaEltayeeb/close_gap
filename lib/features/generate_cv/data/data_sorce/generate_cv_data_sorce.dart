import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/core/network/api_services.dart';
import 'package:injectable/injectable.dart';
 
@injectable
class GenerateCvDataSource {
  final ApiServices apiServices;
 
  GenerateCvDataSource(this.apiServices);
 
  Future<ApiResult<List<int>>> generateCv() async {
    try {
      final response = await apiServices.generateCv();
      return ApiSuccessResult(data: response.data);
    } catch (e) {
      return ApiErrorResult(failure: e.toString());
    }
  }
}
 