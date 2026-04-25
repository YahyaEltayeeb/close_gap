import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:close_gap/features/notifications/presentation/manager/notifications_state.dart';
import 'package:close_gap/features/notifications/presentation/widgets/empty_notifications_card.dart';
import 'package:close_gap/features/notifications/presentation/widgets/notification_card.dart';
import 'package:close_gap/features/notifications/presentation/widgets/notifications_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationsCubit>()..loadNotifications(),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ToastMessage.toastMsg(
            state.errorMessage!,
            backgroundColor: AppColors.red,
          );
          context.read<NotificationsCubit>().clearFeedback();
        }
        if (state.successMessage != null) {
          ToastMessage.toastMsg(state.successMessage!);
          context.read<NotificationsCubit>().clearFeedback();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FB),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF6F8FB),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            title: const Text(
              'Notifications',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () =>
                context.read<NotificationsCubit>().loadNotifications(),
            child: state.isLoading
                ? const NotificationsLoadingView()
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                        children: [
                          _NotificationsSummary(
                            unreadCount: state.unreadCount,
                            total: state.total,
                            page: state.page,
                            pages: state.pages,
                            onMarkAllRead:
                                state.notifications.isEmpty ||
                                    state.isProcessing
                                ? null
                                : () => context
                                      .read<NotificationsCubit>()
                                      .markAllAsRead(),
                            onClearAll:
                                state.notifications.isEmpty ||
                                    state.isProcessing
                                ? null
                                : () => context
                                      .read<NotificationsCubit>()
                                      .clearAll(),
                          ),
                          const SizedBox(height: 18),
                          if (state.notifications.isEmpty)
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight - 180,
                              ),
                              child: const Center(
                                child: EmptyNotificationsCard(),
                              ),
                            )
                          else
                            ...state.notifications.map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: NotificationCard(
                                  notification: item,
                                  onMarkRead: state.isProcessing
                                      ? null
                                      : () => context
                                            .read<NotificationsCubit>()
                                            .markAsRead(item.id),
                                  onDelete: state.isProcessing
                                      ? null
                                      : () => context
                                            .read<NotificationsCubit>()
                                            .deleteNotification(item.id),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}

class _NotificationsSummary extends StatelessWidget {
  const _NotificationsSummary({
    required this.unreadCount,
    required this.total,
    required this.page,
    required this.pages,
    required this.onMarkAllRead,
    required this.onClearAll,
  });

  final int unreadCount;
  final int total;
  final int page;
  final int pages;
  final VoidCallback? onMarkAllRead;
  final VoidCallback? onClearAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Unread Notifications',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF4FF),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '$unreadCount unread',
                  style: const TextStyle(
                    color: AppColors.lightPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Total: $total  •  Page $page of $pages',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onMarkAllRead,
                  child: const Text('Mark All Read'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: onClearAll,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.lightPrimary,
                  ),
                  child: const Text('Clear All'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
