import 'package:json_annotation/json_annotation.dart';

part 'chatbot_request_dto.g.dart';

@JsonSerializable()
class ChatbotRequestDto {
  const ChatbotRequestDto({required this.message});

  final String message;

  factory ChatbotRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ChatbotRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatbotRequestDtoToJson(this);
}
