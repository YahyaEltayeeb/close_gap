import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/chatbot/data/data_source/chatbot_ds.dart';
import 'package:close_gap/features/chatbot/data/mapper/chatbot_mapper.dart';
import 'package:close_gap/features/chatbot/domain/entities/chatbot_request_entity.dart';
import 'package:close_gap/features/chatbot/domain/entities/chatbot_response_entity.dart';
import 'package:close_gap/features/chatbot/domain/repo/chatbot_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatbotRepo)
class ChatbotRepoImp implements ChatbotRepo {
  ChatbotRepoImp(this._chatbotDs);

  final ChatbotDs _chatbotDs;

  @override
  Future<ApiResult<ChatbotResponseEntity>> sendMessage(
    ChatbotRequestEntity requestEntity,
  ) {
    return safeApiCall(() async {
      final response = await _chatbotDs.sendMessage(requestEntity.toDto());
      return response.toEntity();
    });
  }
}
