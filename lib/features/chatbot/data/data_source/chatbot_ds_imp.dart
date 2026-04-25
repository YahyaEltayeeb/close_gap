import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/chatbot/data/data_source/chatbot_ds.dart';
import 'package:close_gap/features/chatbot/data/model/request/chatbot_request_dto.dart';
import 'package:close_gap/features/chatbot/data/model/response/chatbot_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatbotDs)
class ChatbotDsImp implements ChatbotDs {
  ChatbotDsImp(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<ChatbotResponseDto> sendMessage(ChatbotRequestDto requestDto) {
    return _apiServices.sendChatbotMessage(requestDto);
  }
}
