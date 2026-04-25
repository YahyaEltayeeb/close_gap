import 'package:json_annotation/json_annotation.dart';

part 'chatbot_response_dto.g.dart';

@JsonSerializable()
class ChatbotResponseDto {
  const ChatbotResponseDto({required this.response});

  final String response;

  factory ChatbotResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChatbotResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatbotResponseDtoToJson(this);
}
