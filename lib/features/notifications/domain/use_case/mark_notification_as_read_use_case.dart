import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/notifications/domain/repo/notifications_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkNotificationAsReadUseCase {
  MarkNotificationAsReadUseCase(this._notificationsRepo);

  final NotificationsRepo _notificationsRepo;

  Future<ApiResult<void>> call(int notificationId) {
    return _notificationsRepo.markAsRead(notificationId);
  }
}
