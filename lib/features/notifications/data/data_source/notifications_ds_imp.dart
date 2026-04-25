import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/notifications/data/data_source/notifications_ds.dart';
import 'package:close_gap/features/notifications/data/model/response/notifications_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsDs)
class NotificationsDsImp implements NotificationsDs {
  NotificationsDsImp(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<void> clearAll() {
    return _apiServices.clearAllNotifications();
  }

  @override
  Future<void> deleteNotification(int notificationId) {
    return _apiServices.deleteNotification(notificationId);
  }

  @override
  Future<NotificationsResponseDto> getNotifications({
    bool unreadOnly = false,
    int limit = 20,
    int page = 1,
  }) async {
    final response = await _apiServices.getNotifications(
      unreadOnly: unreadOnly,
      limit: limit,
      page: page,
    );
    return NotificationsResponseDto.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<int> getUnreadCount() async {
    final response = await _apiServices.getNotificationsUnreadCount();
    if (response is Map<String, dynamic>) {
      return (response['unread_count'] as num?)?.toInt() ?? 0;
    }
    return 0;
  }

  @override
  Future<void> markAllAsRead() {
    return _apiServices.markAllNotificationsAsRead();
  }

  @override
  Future<void> markAsRead(int notificationId) {
    return _apiServices.markNotificationAsRead(notificationId);
  }
}
