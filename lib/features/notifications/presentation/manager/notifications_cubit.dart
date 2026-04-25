import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/notifications/domain/use_case/clear_all_notifications_use_case.dart';
import 'package:close_gap/features/notifications/domain/use_case/delete_notification_use_case.dart';
import 'package:close_gap/features/notifications/domain/use_case/get_notifications_unread_count_use_case.dart';
import 'package:close_gap/features/notifications/domain/use_case/get_notifications_use_case.dart';
import 'package:close_gap/features/notifications/domain/use_case/mark_all_notifications_as_read_use_case.dart';
import 'package:close_gap/features/notifications/domain/use_case/mark_notification_as_read_use_case.dart';
import 'package:close_gap/features/notifications/presentation/manager/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(
    this._getNotificationsUseCase,
    this._getNotificationsUnreadCountUseCase,
    this._markNotificationAsReadUseCase,
    this._markAllNotificationsAsReadUseCase,
    this._deleteNotificationUseCase,
    this._clearAllNotificationsUseCase,
  ) : super(const NotificationsState());

  final GetNotificationsUseCase _getNotificationsUseCase;
  final GetNotificationsUnreadCountUseCase _getNotificationsUnreadCountUseCase;
  final MarkNotificationAsReadUseCase _markNotificationAsReadUseCase;
  final MarkAllNotificationsAsReadUseCase _markAllNotificationsAsReadUseCase;
  final DeleteNotificationUseCase _deleteNotificationUseCase;
  final ClearAllNotificationsUseCase _clearAllNotificationsUseCase;

  Future<void> loadNotifications() async {
    emit(
      state.copyWith(isLoading: true, errorMessage: null, successMessage: null),
    );

    final notificationsResult = await _getNotificationsUseCase();
    final unreadCountResult = await _getNotificationsUnreadCountUseCase();

    String? errorMessage;
    if (notificationsResult case ApiErrorResult(failure: final failure)) {
      errorMessage = failure;
    } else if (unreadCountResult case ApiErrorResult(failure: final failure)) {
      errorMessage = failure;
    }

    final notifications = switch (notificationsResult) {
      ApiSuccessResult(data: final data) => data.notifications,
      _ => state.notifications,
    };
    final page = switch (notificationsResult) {
      ApiSuccessResult(data: final data) => data.page,
      _ => state.page,
    };
    final pages = switch (notificationsResult) {
      ApiSuccessResult(data: final data) => data.pages,
      _ => state.pages,
    };
    final total = switch (notificationsResult) {
      ApiSuccessResult(data: final data) => data.total,
      _ => state.total,
    };
    final unreadCount = switch (unreadCountResult) {
      ApiSuccessResult(data: final data) => data,
      _ => switch (notificationsResult) {
        ApiSuccessResult(data: final data) => data.unreadCount,
        _ => state.unreadCount,
      },
    };

    emit(
      state.copyWith(
        isLoading: false,
        notifications: notifications,
        page: page,
        pages: pages,
        total: total,
        unreadCount: unreadCount,
        errorMessage: errorMessage,
      ),
    );
  }

  Future<void> markAsRead(int notificationId) async {
    emit(
      state.copyWith(
        isProcessing: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _markNotificationAsReadUseCase(notificationId);
    if (result case ApiErrorResult(failure: final failure)) {
      emit(state.copyWith(isProcessing: false, errorMessage: failure));
      return;
    }

    emit(
      state.copyWith(
        isProcessing: false,
        successMessage: 'Notification marked as read',
      ),
    );
    await loadNotifications();
  }

  Future<void> markAllAsRead() async {
    emit(
      state.copyWith(
        isProcessing: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _markAllNotificationsAsReadUseCase();
    if (result case ApiErrorResult(failure: final failure)) {
      emit(state.copyWith(isProcessing: false, errorMessage: failure));
      return;
    }

    emit(
      state.copyWith(
        isProcessing: false,
        successMessage: 'All notifications marked as read',
      ),
    );
    await loadNotifications();
  }

  Future<void> deleteNotification(int notificationId) async {
    emit(
      state.copyWith(
        isProcessing: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _deleteNotificationUseCase(notificationId);
    if (result case ApiErrorResult(failure: final failure)) {
      emit(state.copyWith(isProcessing: false, errorMessage: failure));
      return;
    }

    emit(
      state.copyWith(
        isProcessing: false,
        successMessage: 'Notification deleted',
      ),
    );
    await loadNotifications();
  }

  Future<void> clearAll() async {
    emit(
      state.copyWith(
        isProcessing: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _clearAllNotificationsUseCase();
    if (result case ApiErrorResult(failure: final failure)) {
      emit(state.copyWith(isProcessing: false, errorMessage: failure));
      return;
    }

    emit(
      state.copyWith(
        isProcessing: false,
        successMessage: 'All notifications cleared',
      ),
    );
    await loadNotifications();
  }

  void clearFeedback() {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }
}
