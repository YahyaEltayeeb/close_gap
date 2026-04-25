import 'package:close_gap/features/notifications/data/model/response/notification_dto.dart';

class NotificationsResponseDto {
  const NotificationsResponseDto({
    required this.notifications,
    required this.page,
    required this.pages,
    required this.total,
    required this.unreadCount,
  });

  final List<NotificationDto> notifications;
  final int page;
  final int pages;
  final int total;
  final int unreadCount;

  factory NotificationsResponseDto.fromJson(Map<String, dynamic> json) {
    final rawNotifications = json['notifications'];
    return NotificationsResponseDto(
      notifications: rawNotifications is List
          ? rawNotifications
                .map(
                  (item) =>
                      NotificationDto.fromJson(item as Map<String, dynamic>),
                )
                .toList()
          : const [],
      page: (json['page'] as num?)?.toInt() ?? 1,
      pages: (json['pages'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? 0,
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
    );
  }
}
