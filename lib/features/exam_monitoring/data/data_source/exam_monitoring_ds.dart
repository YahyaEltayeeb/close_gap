import 'package:close_gap/features/exam_monitoring/data/models/request/vision_check_camera_request.dart';
import 'package:close_gap/features/exam_monitoring/data/models/response/vision_check_camera_response.dart';

abstract class ExamMonitoringDs {
  Future<VisionCheckCameraResponse> visionCheck(VisionCheckCameraRequest visionCheckCameraRequest);
}