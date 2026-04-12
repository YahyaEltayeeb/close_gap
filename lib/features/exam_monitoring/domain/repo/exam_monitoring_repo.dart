import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/exam_monitoring/data/models/request/vision_check_camera_request.dart';
import 'package:close_gap/features/exam_monitoring/domain/entities/vision_check_camera_entity.dart';

abstract class ExamMonitoringRepo {
  Future<ApiResult<VisionCheckCameraEntity>> visionCheck(VisionCheckCameraRequest visionCheckCameraRequest);
}