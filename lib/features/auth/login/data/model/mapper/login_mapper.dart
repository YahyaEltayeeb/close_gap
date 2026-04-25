import 'package:close_gap/features/auth/login/data/model/response/user_model_login_dto.dart';
import 'package:close_gap/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:close_gap/features/auth/login/domain/entities/user_model_login_entity.dart';
import 'package:close_gap/features/auth/login/data/model/request/login_request_dto.dart';

extension LoginMapper on UserModelLoginDto {
  UserModelLoginEntity toEntity() {
    final resolvedName = (fullName ?? '').trim().isNotEmpty
        ? fullName!.trim()
        : (username ?? '').trim();
    final profileMap = profile;
    final resolvedTrackId =
        trackId ?? _readNestedInt(profileMap, 'target_track', 'id');
    final resolvedTrackName = trackName?.trim().isNotEmpty == true
        ? trackName!.trim()
        : _readNestedName(profileMap, 'target_track');
    final resolvedYear = year ?? _readInt(profileMap?['year']);
    final resolvedCurrentSemester =
        currentSemester ?? _readInt(profileMap?['current_semester']);

    return UserModelLoginEntity(
      id: id ?? 0,
      name: resolvedName,
      email: email ?? '',
      role: (role ?? 'student').trim().toLowerCase(),
      trackId: resolvedTrackId,
      trackName: resolvedTrackName,
      year: resolvedYear,
      currentSemester: resolvedCurrentSemester,
      pathType: _readString(profileMap?['path_type']),
      universityId:
          _readInt(profileMap?['university_id']) ??
          _readNestedInt(profileMap, 'university', 'id'),
      universityName: _readDisplayValue(profileMap?['university']),
      facultyId:
          _readInt(profileMap?['faculty_id']) ??
          _readNestedInt(profileMap, 'faculty', 'id'),
      facultyName: _readDisplayValue(profileMap?['faculty']),
      departmentId:
          _readInt(profileMap?['department_id']) ??
          _readNestedInt(profileMap, 'department', 'id'),
      departmentName: _readDisplayValue(profileMap?['department']),
      skills: skills?.map((skill) => skill.toString()).toList() ?? [],
      exams: exams ?? const [],
    );
  }
}

extension LoginMapperToDto on LoginRequestEntity {
  LoginRequestDto toDto() {
    return LoginRequestDto(username: userName, password: password);
  }
}

int? _readInt(dynamic value) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value.trim());
  return null;
}

String? _readString(dynamic value) {
  if (value is String && value.trim().isNotEmpty) {
    return value.trim();
  }
  return null;
}

int? _readNestedInt(
  Map<String, dynamic>? parent,
  String parentKey,
  String nestedKey,
) {
  final nested = parent?[parentKey];
  if (nested is Map<String, dynamic>) {
    return _readInt(nested[nestedKey]);
  }
  return null;
}

String? _readNestedName(Map<String, dynamic>? parent, String parentKey) {
  final nested = parent?[parentKey];
  return _readDisplayValue(nested);
}

String? _readDisplayValue(dynamic value) {
  if (value is String && value.trim().isNotEmpty) {
    return value.trim();
  }
  if (value is Map<String, dynamic>) {
    return _readString(value['name']) ?? _readString(value['title']);
  }
  return null;
}
