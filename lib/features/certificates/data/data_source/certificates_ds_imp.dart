import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/certificates/data/data_source/certificates_ds.dart';
import 'package:close_gap/features/certificates/data/model/request/create_certificate_request_dto.dart';
import 'package:close_gap/features/certificates/data/model/response/certificate_dto.dart';
import 'package:close_gap/features/projects/data/model/response/skill_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/academic_course_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CertificatesDs)
class CertificatesDsImp implements CertificatesDs {
  CertificatesDsImp(this._apiServices);

  final ApiServices _apiServices;

  List<dynamic> _extractList(dynamic response) {
    if (response is List) return response;
    if (response is Map<String, dynamic>) {
      for (final key in [
        'data',
        'results',
        'items',
        'certificates',
        'skills',
      ]) {
        final value = response[key];
        if (value is List) return value;
      }
    }
    throw Exception('Unexpected response format');
  }

  @override
  Future<void> createCertificate(CreateCertificateRequestDto requestDto) {
    return _apiServices.createCertificate(requestDto);
  }

  @override
  Future<List<CertificateDto>> getCertificates() async {
    final response = await _apiServices.getCertificates();
    final rawList = _extractList(response);
    return rawList
        .map((item) => CertificateDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<AcademicCourseDto>> getCourses() {
    return _apiServices.getAcademicCourses();
  }

  @override
  Future<List<SkillDto>> getSkills() async {
    final response = await _apiServices.getSkills();
    final rawList = _extractList(response);
    return rawList
        .map((item) => SkillDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
