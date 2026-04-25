import 'package:close_gap/features/chatbot/presentation/models/chat_message.dart';

class ChatbotState {
  static const _sentinel = Object();

  const ChatbotState({
    this.messages = const [
      ChatMessage(
        text:
            'اهلاً بيك، ابعت سؤالك وأنا هحاول أساعدك بشرح واضح وبسيط.',
        isUser: false,
      ),
    ],
    this.isSending = false,
    this.errorMessage,
  });

  final List<ChatMessage> messages;
  final bool isSending;
  final String? errorMessage;

  ChatbotState copyWith({
    List<ChatMessage>? messages,
    bool? isSending,
    Object? errorMessage = _sentinel,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
