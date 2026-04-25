import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/generate_cv/data/model/request/generate_cv_request_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class GenerateCvDataSource {
  final ApiServices apiServices;

  GenerateCvDataSource(this.apiServices);

  Future<ApiResult<List<int>>> generateCv(
    GenerateCvRequestDto requestDto,
  ) async {
    try {
      final response = await apiServices.generateCv(requestDto);
      return ApiSuccessResult(data: response.data);
    } on DioException catch (e) {
      final responseData = e.response?.data;
      String? serverMessage;

      if (responseData is List<int> && responseData.isNotEmpty) {
        serverMessage = utf8.decode(responseData, allowMalformed: true).trim();
      } else if (responseData is String && responseData.isNotEmpty) {
        serverMessage = responseData.trim();
      }

      return ApiErrorResult(
        failure: serverMessage == null || serverMessage.isEmpty
            ? (e.message ?? 'Failed to generate CV')
            : serverMessage,
      );
    } catch (e) {
      return ApiErrorResult(failure: e.toString());
    }
  }
}
