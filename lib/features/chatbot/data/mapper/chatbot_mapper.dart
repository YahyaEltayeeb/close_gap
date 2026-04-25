import 'package:close_gap/features/chatbot/data/model/request/chatbot_request_dto.dart';
import 'package:close_gap/features/chatbot/data/model/response/chatbot_response_dto.dart';
import 'package:close_gap/features/chatbot/domain/entities/chatbot_request_entity.dart';
import 'package:close_gap/features/chatbot/domain/entities/chatbot_response_entity.dart';

extension ChatbotRequestMapper on ChatbotRequestEntity {
  ChatbotRequestDto toDto() {
    return ChatbotRequestDto(message: message);
  }
}

extension ChatbotResponseMapper on ChatbotResponseDto {
  ChatbotResponseEntity toEntity() {
    return ChatbotResponseEntity(response: response);
  }
}
