import 'package:close_gap/features/notifications/domain/entities/notification_item.dart';

class NotificationsState {
  static const _sentinel = Object();

  const NotificationsState({
    this.isLoading = false,
    this.isProcessing = false,
    this.notifications = const [],
    this.errorMessage,
    this.successMessage,
    this.page = 1,
    this.pages = 1,
    this.total = 0,
    this.unreadCount = 0,
  });

  final bool isLoading;
  final bool isProcessing;
  final List<NotificationItem> notifications;
  final String? errorMessage;
  final String? successMessage;
  final int page;
  final int pages;
  final int total;
  final int unreadCount;

  NotificationsState copyWith({
    bool? isLoading,
    bool? isProcessing,
    List<NotificationItem>? notifications,
    Object? errorMessage = _sentinel,
    Object? successMessage = _sentinel,
    int? page,
    int? pages,
    int? total,
    int? unreadCount,
  }) {
    return NotificationsState(
      isLoading: isLoading ?? this.isLoading,
      isProcessing: isProcessing ?? this.isProcessing,
      notifications: notifications ?? this.notifications,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      successMessage: identical(successMessage, _sentinel)
          ? this.successMessage
          : successMessage as String?,
      page: page ?? this.page,
      pages: pages ?? this.pages,
      total: total ?? this.total,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
