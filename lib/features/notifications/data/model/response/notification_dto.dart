class NotificationDto {
  const NotificationDto({
    required this.id,
    required this.userId,
    required this.message,
    required this.createdAt,
    required this.read,
  });

  final int id;
  final int userId;
  final String message;
  final String createdAt;
  final bool read;

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      userId: (json['user_id'] as num?)?.toInt() ?? 0,
      message: json['message']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      read: json['read'] as bool? ?? false,
    );
  }
}
