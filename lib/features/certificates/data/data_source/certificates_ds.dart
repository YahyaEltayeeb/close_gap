import 'package:close_gap/features/certificates/data/model/request/create_certificate_request_dto.dart';
import 'package:close_gap/features/certificates/data/model/response/certificate_dto.dart';
import 'package:close_gap/features/projects/data/model/response/skill_dto.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/academic_course_dto.dart';

abstract class CertificatesDs {
  Future<List<CertificateDto>> getCertificates();

  Future<void> createCertificate(CreateCertificateRequestDto requestDto);

  Future<List<SkillDto>> getSkills();

  Future<List<TeacherAcademicCourseDto>> getCourses();
}
