import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/notifications/domain/entities/notifications_result_entity.dart';

abstract class NotificationsRepo {
  Future<ApiResult<NotificationsResultEntity>> getNotifications({
    bool unreadOnly = false,
    int limit = 20,
    int page = 1,
  });

  Future<ApiResult<int>> getUnreadCount();

  Future<ApiResult<void>> markAsRead(int notificationId);

  Future<ApiResult<void>> markAllAsRead();

  Future<ApiResult<void>> deleteNotification(int notificationId);

  Future<ApiResult<void>> clearAll();
}
