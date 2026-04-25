import 'package:close_gap/features/notifications/domain/entities/notification_item.dart';

class NotificationsResultEntity {
  const NotificationsResultEntity({
    required this.notifications,
    required this.page,
    required this.pages,
    required this.total,
    required this.unreadCount,
  });

  final List<NotificationItem> notifications;
  final int page;
  final int pages;
  final int total;
  final int unreadCount;
}
