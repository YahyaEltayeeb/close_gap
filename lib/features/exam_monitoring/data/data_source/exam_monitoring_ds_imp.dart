import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/exam_monitoring/data/data_source/exam_monitoring_ds.dart';
import 'package:close_gap/features/exam_monitoring/data/models/request/vision_check_camera_request.dart';
import 'package:close_gap/features/exam_monitoring/data/models/response/vision_check_camera_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ExamMonitoringDs)
class ExamMonitoringDsImp implements ExamMonitoringDs {
  final ApiServices _apiServices;
  ExamMonitoringDsImp(this._apiServices);
  @override
  Future<VisionCheckCameraResponse> visionCheck(VisionCheckCameraRequest visionCheckCameraRequest) {
    return _apiServices.visionCheck( visionCheckCameraRequest);
  }
}