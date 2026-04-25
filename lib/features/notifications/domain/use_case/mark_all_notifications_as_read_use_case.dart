import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/notifications/domain/repo/notifications_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkAllNotificationsAsReadUseCase {
  MarkAllNotificationsAsReadUseCase(this._notificationsRepo);

  final NotificationsRepo _notificationsRepo;

  Future<ApiResult<void>> call() {
    return _notificationsRepo.markAllAsRead();
  }
}
