import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/chatbot/domain/entities/chatbot_request_entity.dart';
import 'package:close_gap/features/chatbot/domain/entities/chatbot_response_entity.dart';
import 'package:close_gap/features/chatbot/domain/repo/chatbot_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendChatbotMessageUseCase {
  SendChatbotMessageUseCase(this._chatbotRepo);

  final ChatbotRepo _chatbotRepo;

  Future<ApiResult<ChatbotResponseEntity>> call(
    ChatbotRequestEntity requestEntity,
  ) {
    return _chatbotRepo.sendMessage(requestEntity);
  }
}
