import 'package:close_gap/features/compare_cv/data/model/request/compare_cv_request_dto.dart';
import 'package:close_gap/features/compare_cv/data/model/response/compare_cv_response_dto.dart';

abstract class CompareCvDataSource {
  Future<CompareCvResponseDto> compareCv(CompareCvRequestDto request);
}
