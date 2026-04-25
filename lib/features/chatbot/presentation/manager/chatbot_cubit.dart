import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/chatbot/domain/entities/chatbot_request_entity.dart';
import 'package:close_gap/features/chatbot/domain/use_case/send_chatbot_message_use_case.dart';
import 'package:close_gap/features/chatbot/presentation/manager/chatbot_state.dart';
import 'package:close_gap/features/chatbot/presentation/models/chat_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatbotCubit extends Cubit<ChatbotState> {
  ChatbotCubit(this._sendChatbotMessageUseCase) : super(const ChatbotState());

  final SendChatbotMessageUseCase _sendChatbotMessageUseCase;

  Future<void> sendMessage(String message) async {
    final trimmedMessage = message.trim();
    if (trimmedMessage.isEmpty || state.isSending) {
      return;
    }

    final updatedMessages = [
      ...state.messages,
      ChatMessage(text: trimmedMessage, isUser: true),
    ];

    emit(
      state.copyWith(
        messages: updatedMessages,
        isSending: true,
        errorMessage: null,
      ),
    );

    final result = await _sendChatbotMessageUseCase(
      ChatbotRequestEntity(message: trimmedMessage),
    );

    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isSending: false,
            messages: [
              ...updatedMessages,
              ChatMessage(text: result.data.response, isUser: false),
            ],
            errorMessage: null,
          ),
        );
      case ApiErrorResult():
        emit(
          state.copyWith(
            isSending: false,
            errorMessage: result.failure,
          ),
        );
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
