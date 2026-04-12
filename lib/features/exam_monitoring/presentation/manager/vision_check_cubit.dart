import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/features/exam_monitoring/domain/entities/vision_check_camera_entity.dart';
import 'package:close_gap/features/exam_monitoring/domain/use_case/exam_monitoring_use_case.dart';
import 'package:close_gap/features/exam_monitoring/data/models/request/vision_check_camera_request.dart';
import 'package:close_gap/core/network/api_results.dart';
import 'package:injectable/injectable.dart';

part 'vision_check_state.dart';

@Injectable()
class VisionCheckCubit extends Cubit<VisionCheckState> {
  final ExamMonitoringUseCase _useCase;
  bool _startRequested = false;
  int _localStrikes = 0;
  DateTime? _lastStrikeTime;

  VisionCheckCubit(this._useCase) : super(VisionCheckInitial());

  Timer? _timer;
  int _examId = 0;
  bool _running = false;
  bool _isDisposed = false; // ✅ flag للحماية

  void startMonitoring({
    required int examId,
    required Future<File> Function() captureImage,
  }) {
    if (_running || _isDisposed || _timer != null) return;
    _startRequested = true; // 👈 هنا

    _running = true;
    _examId = examId;
    emit(VisionCheckRunning());

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      // ✅ تأكد إن الـ cubit لسه شغال
      if (_isDisposed || isClosed) {
        timer.cancel();
        return;
      }

      try {
        final file = await captureImage();

        // ✅ تأكد تاني بعد الـ async
        if (_isDisposed || isClosed) return;

        final base64Image = base64Encode(await file.readAsBytes());

        // ✅ تأكد تالت قبل الـ API call
        if (_isDisposed || isClosed) return;

        final result = await _useCase(
          VisionCheckCameraRequest(examId: _examId, image: base64Image),
        );

        // ✅ تأكد رابع بعد الـ API response
        if (_isDisposed || isClosed) return;

        if (result is ApiSuccessResult<VisionCheckCameraEntity>) {
          _handleResult(result.data);
        } else if (result is ApiErrorResult<VisionCheckCameraEntity>) {
          if (!_isDisposed && !isClosed) {
            emit(VisionCheckError(result.failure.toString()));
          }
        }
      } catch (e) {
        // ✅ تجاهل connection errors عشان متوقفش الـ monitoring
        if (!_isDisposed && !isClosed) {
          if (e.toString().contains('HandshakeException') ||
              e.toString().contains('Connection') ||
              e.toString().contains('disposed') ||
              e.toString().contains('not ready')) {
            return;
          }
          emit(const VisionCheckError("Camera error"));
        }
      }
    });
  }

  void _handleResult(VisionCheckCameraEntity entity) {
    if (_isDisposed || isClosed) return;

    final now = DateTime.now();

    print("🔥 API INVALIDATED: ${entity.invalidated}");
    print("🔥 API STRIKES: ${entity.strikes}");
    final isSuspicious = entity.result?.phoneDetected == true;
    if (isSuspicious) {
      if (_lastStrikeTime == null ||
          now.difference(_lastStrikeTime!).inSeconds > 5) {
        _localStrikes++;
        _lastStrikeTime = now;
      }
    } else {
      if (_lastStrikeTime != null &&
          now.difference(_lastStrikeTime!).inSeconds > 10) {
        _localStrikes = 0;
        _lastStrikeTime = null;
      }
    }

    // ✅ القرار النهائي عندك انت
    if (_localStrikes >= 3) {
      emit(VisionCheckInvalidated());
      stopMonitoring();
      return;
    }

    if (_localStrikes > 0) {
      emit(VisionCheckWarning(_localStrikes));
    } else {
      emit(VisionCheckSafe());
    }
  }

  void stopMonitoring() {
    _isDisposed = true;
    _startRequested = false; // 👈 هنا // ✅ أوقف كل حاجة
    _timer?.cancel();
    _timer = null;
    _running = false;
    if (!isClosed) emit(VisionCheckInitial());
  }

  @override
  Future<void> close() {
    _isDisposed = true;
    _timer?.cancel();
    _timer = null;
    return super.close();
  }
}
