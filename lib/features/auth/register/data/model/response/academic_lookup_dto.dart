import 'package:json_annotation/json_annotation.dart';

part 'academic_lookup_dto.g.dart';

@JsonSerializable()
class AcademicLookupDto {
  final int id;
  final String name;

  const AcademicLookupDto({
    required this.id,
    required this.name,
  });

  factory AcademicLookupDto.fromJson(Map<String, dynamic> json) =>
      _$AcademicLookupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AcademicLookupDtoToJson(this);
}
