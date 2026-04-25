import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/notifications/data/data_source/notifications_ds.dart';
import 'package:close_gap/features/notifications/data/model/mapper/notifications_mapper.dart';
import 'package:close_gap/features/notifications/domain/entities/notifications_result_entity.dart';
import 'package:close_gap/features/notifications/domain/repo/notifications_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsRepo)
class NotificationsRepoImp implements NotificationsRepo {
  NotificationsRepoImp(this._notificationsDs);

  final NotificationsDs _notificationsDs;

  @override
  Future<ApiResult<void>> clearAll() {
    return safeApiCall(() => _notificationsDs.clearAll());
  }

  @override
  Future<ApiResult<void>> deleteNotification(int notificationId) {
    return safeApiCall(
      () => _notificationsDs.deleteNotification(notificationId),
    );
  }

  @override
  Future<ApiResult<NotificationsResultEntity>> getNotifications({
    bool unreadOnly = false,
    int limit = 20,
    int page = 1,
  }) {
    return safeApiCall(() async {
      final result = await _notificationsDs.getNotifications(
        unreadOnly: unreadOnly,
        limit: limit,
        page: page,
      );
      return result.toEntity();
    });
  }

  @override
  Future<ApiResult<int>> getUnreadCount() {
    return safeApiCall(() => _notificationsDs.getUnreadCount());
  }

  @override
  Future<ApiResult<void>> markAllAsRead() {
    return safeApiCall(() => _notificationsDs.markAllAsRead());
  }

  @override
  Future<ApiResult<void>> markAsRead(int notificationId) {
    return safeApiCall(() => _notificationsDs.markAsRead(notificationId));
  }
}
