import 'package:close_gap/features/notifications/data/model/response/notifications_response_dto.dart';

abstract class NotificationsDs {
  Future<NotificationsResponseDto> getNotifications({
    bool unreadOnly = false,
    int limit = 20,
    int page = 1,
  });

  Future<int> getUnreadCount();

  Future<void> markAsRead(int notificationId);

  Future<void> markAllAsRead();

  Future<void> deleteNotification(int notificationId);

  Future<void> clearAll();
}
