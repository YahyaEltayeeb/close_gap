import 'package:json_annotation/json_annotation.dart';

part 'semester_lookup_dto.g.dart';

@JsonSerializable()
class SemesterLookupDto {
  final int semester;
  final int year;
  final String label;

  const SemesterLookupDto({
    required this.semester,
    required this.year,
    required this.label,
  });

  factory SemesterLookupDto.fromJson(Map<String, dynamic> json) =>
      _$SemesterLookupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SemesterLookupDtoToJson(this);
}
