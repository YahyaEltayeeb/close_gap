import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/compare_cv/data/data_source/compare_cv_data_source.dart';
import 'package:close_gap/features/compare_cv/data/model/request/compare_cv_request_dto.dart';
import 'package:close_gap/features/compare_cv/data/model/response/compare_cv_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CompareCvDataSource)
class CompareCvDataSourceImp implements CompareCvDataSource {
  final ApiServices _apiServices;
  CompareCvDataSourceImp(this._apiServices);

  @override
  Future<CompareCvResponseDto> compareCv(CompareCvRequestDto request) {
    return _apiServices.compareCv(request);
  }
}
