import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/experience/data/data_source/experience_ds.dart';
import 'package:close_gap/features/experience/data/model/request/experience_request_dto.dart';
import 'package:close_gap/features/experience/data/model/response/experience_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExperienceDs)
class ExperienceDsImp implements ExperienceDs {
  ExperienceDsImp(this._apiServices);

  final ApiServices _apiServices;

  List<dynamic> _extractList(dynamic response) {
    if (response is List) return response;
    if (response is Map<String, dynamic>) {
      for (final key in ['data', 'results', 'items', 'experiences']) {
        final value = response[key];
        if (value is List) return value;
      }
    }
    throw Exception('Unexpected response format');
  }

  @override
  Future<void> createExperience(ExperienceRequestDto requestDto) {
    return _apiServices.createExperience(requestDto);
  }

  @override
  Future<void> deleteExperience(int experienceId) {
    return _apiServices.deleteExperience(experienceId);
  }

  @override
  Future<List<ExperienceDto>> getExperiences() async {
    final response = await _apiServices.getExperiences();
    final rawList = _extractList(response);
    return rawList
        .map((item) => ExperienceDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> updateExperience(
    int experienceId,
    ExperienceRequestDto requestDto,
  ) {
    return _apiServices.updateExperience(experienceId, requestDto);
  }
}
