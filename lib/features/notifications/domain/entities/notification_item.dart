class NotificationItem {
  const NotificationItem({
    required this.id,
    required this.userId,
    required this.message,
    required this.createdAt,
    required this.isRead,
  });

  final int id;
  final int userId;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  NotificationItem copyWith({
    int? id,
    int? userId,
    String? message,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}
