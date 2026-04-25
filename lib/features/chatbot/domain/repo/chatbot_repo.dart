import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/chatbot/domain/entities/chatbot_request_entity.dart';
import 'package:close_gap/features/chatbot/domain/entities/chatbot_response_entity.dart';

abstract class ChatbotRepo {
  Future<ApiResult<ChatbotResponseEntity>> sendMessage(
    ChatbotRequestEntity requestEntity,
  );
}
