import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/exam_monitoring/data/data_source/exam_monitoring_ds.dart';
import 'package:close_gap/features/exam_monitoring/data/models/request/vision_check_camera_request.dart';
import 'package:close_gap/features/exam_monitoring/data/models/response/vision_check_camera_response.dart';
import 'package:close_gap/features/exam_monitoring/domain/entities/vision_check_camera_entity.dart';
import 'package:close_gap/features/exam_monitoring/domain/repo/exam_monitoring_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamMonitoringRepo)
class ExamMonitoringRepoImp implements ExamMonitoringRepo {
  final ExamMonitoringDs _examMonitoringDs;
  ExamMonitoringRepoImp(this._examMonitoringDs);

  @override
  Future<ApiResult<VisionCheckCameraEntity>> visionCheck(
    VisionCheckCameraRequest visionCheckCameraRequest,
  ) async {
    return await safeApiCall(() async {
      final result = await _examMonitoringDs.visionCheck(
        visionCheckCameraRequest,
      );
      return result.toEntity();
    });
  }
}
