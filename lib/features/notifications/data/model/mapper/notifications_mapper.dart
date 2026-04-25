import 'package:close_gap/features/notifications/data/model/response/notification_dto.dart';
import 'package:close_gap/features/notifications/data/model/response/notifications_response_dto.dart';
import 'package:close_gap/features/notifications/domain/entities/notification_item.dart';
import 'package:close_gap/features/notifications/domain/entities/notifications_result_entity.dart';

extension NotificationDtoMapper on NotificationDto {
  NotificationItem toEntity() {
    return NotificationItem(
      id: id,
      userId: userId,
      message: message,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime(2000),
      isRead: read,
    );
  }
}

extension NotificationsResponseDtoMapper on NotificationsResponseDto {
  NotificationsResultEntity toEntity() {
    return NotificationsResultEntity(
      notifications: notifications.map((item) => item.toEntity()).toList(),
      page: page,
      pages: pages,
      total: total,
      unreadCount: unreadCount,
    );
  }
}
