import 'package:close_gap/features/certificates/data/model/request/create_certificate_request_dto.dart';
import 'package:close_gap/features/certificates/data/model/response/certificate_dto.dart';
import 'package:close_gap/features/certificates/domain/entities/certificate_item.dart';
import 'package:close_gap/features/certificates/domain/entities/certificate_request_entity.dart';
import 'package:close_gap/features/certificates/domain/entities/course_option_entity.dart';
import 'package:close_gap/features/teacher_exams/data/model/response/academic_course_dto.dart';

extension CertificateRequestEntityMapper on CertificateRequestEntity {
  CreateCertificateRequestDto toDto() {
    return CreateCertificateRequestDto(
      title: title,
      skillId: skillId,
      courseId: courseId,
    );
  }
}

extension CertificateDtoMapper on CertificateDto {
  CertificateItem toEntity() {
    return CertificateItem(
      id: id,
      title: title,
      skillId: skillId,
      courseId: courseId,
      issuedAt: DateTime.tryParse(issuedAt ?? ''),
      provider: provider,
      credentialUrl: credentialUrl,
    );
  }
}

extension AcademicCourseDtoMapper on AcademicCourseDto {
  CourseOptionEntity toCourseEntity() {
    return CourseOptionEntity(
      id: id ?? 0,
      name: name ?? 'Unknown Course',
      code: code,
      semester: semester,
    );
  }
}
