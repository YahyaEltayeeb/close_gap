import 'package:close_gap/features/auth/register/data/model/request/profile_setup_dto.dart';
import 'package:close_gap/features/auth/register/data/model/request/register_request_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/academic_lookup_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/register_response_dto.dart';
import 'package:close_gap/features/auth/register/data/model/response/semester_lookup_dto.dart';
import 'package:close_gap/features/auth/register/domain/entities/academic_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/profile_setup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/semester_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/user_register_entity.dart';

extension RegisterToDto on RegisterRequestEntity {
  RegisterRequestDto toDto() {
    return RegisterRequestDto(
      email: email,
      password: password,
      username: name,
      role: role,
      profileSetup: profileSetup?.toDto(),
    );
  }
}

extension ProfileSetupToDto on ProfileSetupEntity {
  ProfileSetupDto toDto() {
    return ProfileSetupDto(
      universityId: universityId,
      facultyId: facultyId,
      departmentId: departmentId,
      targetTrackId: targetTrackId,
      year: year,
      currentSemester: currentSemester,
      pathType: pathType,
    );
  }
}

extension RegisterToEntity on RegisterResponseDto {
  UserEntity toEntity() {
    return UserEntity(
      id: user?.id ?? 0,
      name: user?.username ?? '',
      email: user?.email ?? '',
    );
  }
}

extension AcademicLookupDtoMapper on AcademicLookupDto {
  AcademicLookupEntity toEntity() {
    return AcademicLookupEntity(
      id: id,
      name: name,
    );
  }
}

extension SemesterLookupDtoMapper on SemesterLookupDto {
  SemesterLookupEntity toEntity() {
    return SemesterLookupEntity(
      semester: semester,
      year: year,
      label: label,
    );
  }
}
