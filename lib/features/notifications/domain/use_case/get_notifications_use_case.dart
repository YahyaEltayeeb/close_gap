import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/notifications/domain/entities/notifications_result_entity.dart';
import 'package:close_gap/features/notifications/domain/repo/notifications_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationsUseCase {
  GetNotificationsUseCase(this._notificationsRepo);

  final NotificationsRepo _notificationsRepo;

  Future<ApiResult<NotificationsResultEntity>> call({
    bool unreadOnly = false,
    int limit = 20,
    int page = 1,
  }) {
    return _notificationsRepo.getNotifications(
      unreadOnly: unreadOnly,
      limit: limit,
      page: page,
    );
  }
}
