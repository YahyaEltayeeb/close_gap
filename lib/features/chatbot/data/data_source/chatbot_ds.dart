import 'package:close_gap/features/chatbot/data/model/request/chatbot_request_dto.dart';
import 'package:close_gap/features/chatbot/data/model/response/chatbot_response_dto.dart';

abstract class ChatbotDs {
  Future<ChatbotResponseDto> sendMessage(ChatbotRequestDto requestDto);
}
