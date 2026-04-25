import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

@injectable
class TokenService {
  final FlutterSecureStorage _prefs;
  final SharedPreferences _sharedPreferences;

  TokenService({
    required FlutterSecureStorage prefs,
    required SharedPreferences sharedPreferences,
  }) : _prefs = prefs,
       _sharedPreferences = sharedPreferences;

  bool get isTokenSaved =>
      _sharedPreferences.getBool(AppConstants.isTokenSaved) ?? false;

  Future<void> saveToken(String token) async {
    await _sharedPreferences.setBool(AppConstants.isTokenSaved, true);
    await _prefs.write(key: AppConstants.token, value: token);
  }

  Future<void> saveUserSession({
    required String token,
    required String role,
    required String name,
    required String email,
    required int? trackId,
    required String? trackName,
    required int? year,
    required int? currentSemester,
    required String? pathType,
    required int? universityId,
    required String? universityName,
    required int? facultyId,
    required String? facultyName,
    required int? departmentId,
    required String? departmentName,
  }) async {
    final normalizedName = name.trim();
    final normalizedEmail = email.trim();
    final normalizedTrackName = trackName?.trim();
    final normalizedPathType = pathType?.trim();
    final normalizedUniversityName = universityName?.trim();
    final normalizedFacultyName = facultyName?.trim();
    final normalizedDepartmentName = departmentName?.trim();

    await saveToken(token);
    await _sharedPreferences.setString(
      AppConstants.userRole,
      role.trim().toLowerCase(),
    );
    await _sharedPreferences.setString(AppConstants.userName, normalizedName);
    if (normalizedEmail.isNotEmpty) {
      await _sharedPreferences.setString(
        AppConstants.userEmail,
        normalizedEmail,
      );
    } else {
      await _sharedPreferences.remove(AppConstants.userEmail);
    }
    await saveAcademicProfile(
      trackId: trackId,
      trackName: normalizedTrackName,
      year: year,
      currentSemester: currentSemester,
      pathType: normalizedPathType,
      universityId: universityId,
      universityName: normalizedUniversityName,
      facultyId: facultyId,
      facultyName: normalizedFacultyName,
      departmentId: departmentId,
      departmentName: normalizedDepartmentName,
      normalizedName: normalizedName,
    );
  }

  Future<void> saveAcademicProfile({
    required int? trackId,
    required String? trackName,
    required int? year,
    required int? currentSemester,
    required String? pathType,
    required int? universityId,
    required String? universityName,
    required int? facultyId,
    required String? facultyName,
    required int? departmentId,
    required String? departmentName,
    String? normalizedName,
  }) async {
    final safeNormalizedName = normalizedName ?? getSavedName()?.trim() ?? '';
    final normalizedTrackName = trackName?.trim();
    final normalizedPathType = pathType?.trim();
    final normalizedUniversityName = universityName?.trim();
    final normalizedFacultyName = facultyName?.trim();
    final normalizedDepartmentName = departmentName?.trim();

    if (trackId != null) {
      await _sharedPreferences.setInt(AppConstants.userTrackId, trackId);
    } else {
      await _sharedPreferences.remove(AppConstants.userTrackId);
    }
    if (normalizedTrackName != null &&
        normalizedTrackName.isNotEmpty &&
        normalizedTrackName.toLowerCase() != safeNormalizedName.toLowerCase()) {
      await _sharedPreferences.setString(
        AppConstants.userTrackName,
        normalizedTrackName,
      );
    } else {
      await _sharedPreferences.remove(AppConstants.userTrackName);
    }

    await _saveNullableInt(AppConstants.userYear, year);
    await _saveNullableInt(AppConstants.userCurrentSemester, currentSemester);
    await _saveNullableString(AppConstants.userPathType, normalizedPathType);
    await _saveNullableInt(AppConstants.userUniversityId, universityId);
    await _saveNullableString(
      AppConstants.userUniversityName,
      normalizedUniversityName,
    );
    await _saveNullableInt(AppConstants.userFacultyId, facultyId);
    await _saveNullableString(
      AppConstants.userFacultyName,
      normalizedFacultyName,
    );
    await _saveNullableInt(AppConstants.userDepartmentId, departmentId);
    await _saveNullableString(
      AppConstants.userDepartmentName,
      normalizedDepartmentName,
    );
  }

  Future<String?> getToken() async {
    final token = await _prefs.read(key: AppConstants.token);
    final hasToken = token != null && token.isNotEmpty;

    if (_sharedPreferences.getBool(AppConstants.isTokenSaved) != hasToken) {
      await _sharedPreferences.setBool(AppConstants.isTokenSaved, hasToken);
    }

    return hasToken ? token : null;
  }

  String? getSavedRole() {
    final role = _sharedPreferences.getString(AppConstants.userRole);
    if (role == null || role.trim().isEmpty) return null;
    return role.trim().toLowerCase();
  }

  String? getSavedName() {
    final name = _sharedPreferences.getString(AppConstants.userName);
    if (name == null || name.trim().isEmpty) return null;
    return name.trim();
  }

  String? getSavedEmail() {
    final email = _sharedPreferences.getString(AppConstants.userEmail);
    if (email == null || email.trim().isEmpty) return null;
    return email.trim();
  }

  int? getSavedTrackId() {
    return _sharedPreferences.getInt(AppConstants.userTrackId);
  }

  int? getSavedYear() {
    return _sharedPreferences.getInt(AppConstants.userYear);
  }

  int? getSavedCurrentSemester() {
    return _sharedPreferences.getInt(AppConstants.userCurrentSemester);
  }

  String? getSavedPathType() {
    final pathType = _sharedPreferences.getString(AppConstants.userPathType);
    if (pathType == null || pathType.trim().isEmpty) return null;
    return pathType.trim();
  }

  int? getSavedUniversityId() {
    return _sharedPreferences.getInt(AppConstants.userUniversityId);
  }

  String? getSavedUniversityName() {
    return _getTrimmedString(AppConstants.userUniversityName);
  }

  int? getSavedFacultyId() {
    return _sharedPreferences.getInt(AppConstants.userFacultyId);
  }

  String? getSavedFacultyName() {
    return _getTrimmedString(AppConstants.userFacultyName);
  }

  int? getSavedDepartmentId() {
    return _sharedPreferences.getInt(AppConstants.userDepartmentId);
  }

  String? getSavedDepartmentName() {
    return _getTrimmedString(AppConstants.userDepartmentName);
  }

  String? getSavedTrackName() {
    final savedUserName = getSavedName()?.trim().toLowerCase();
    final primaryTrackName = _sharedPreferences.getString(
      AppConstants.userTrackName,
    );
    if (primaryTrackName != null && primaryTrackName.trim().isNotEmpty) {
      final normalizedPrimaryTrackName = primaryTrackName.trim();
      if (normalizedPrimaryTrackName.toLowerCase() != savedUserName) {
        return normalizedPrimaryTrackName;
      }
      _sharedPreferences.remove(AppConstants.userTrackName);
    }

    const fallbackKeys = [
      'trackName',
      'track',
      'track_name',
      'user_track_name',
      'selectedTrack',
      'selected_track',
    ];
    for (final key in fallbackKeys) {
      final fallbackTrackName = _sharedPreferences.getString(key);
      if (fallbackTrackName != null && fallbackTrackName.trim().isNotEmpty) {
        final normalizedTrackName = fallbackTrackName.trim();
        if (normalizedTrackName.toLowerCase() == savedUserName) continue;
        _sharedPreferences.setString(
          AppConstants.userTrackName,
          normalizedTrackName,
        );
        return normalizedTrackName;
      }
    }

    for (final key in _sharedPreferences.getKeys()) {
      final normalizedKey = key.toLowerCase();
      if (!normalizedKey.contains('track')) continue;

      final dynamic value = _sharedPreferences.get(key);
      if (value is! String || value.trim().isEmpty) continue;

      final normalizedTrackName = value.trim();
      if (normalizedTrackName.toLowerCase() == savedUserName) continue;
      _sharedPreferences.setString(
        AppConstants.userTrackName,
        normalizedTrackName,
      );
      return normalizedTrackName;
    }

    return null;
  }

  Future<void> deleteToken() async {
    await _sharedPreferences.setBool(AppConstants.isTokenSaved, false);
    await _sharedPreferences.remove(AppConstants.userRole);
    await _sharedPreferences.remove(AppConstants.userName);
    await _sharedPreferences.remove(AppConstants.userEmail);
    await _sharedPreferences.remove(AppConstants.userTrackId);
    await _sharedPreferences.remove(AppConstants.userTrackName);
    await _sharedPreferences.remove(AppConstants.userYear);
    await _sharedPreferences.remove(AppConstants.userCurrentSemester);
    await _sharedPreferences.remove(AppConstants.userPathType);
    await _sharedPreferences.remove(AppConstants.userUniversityId);
    await _sharedPreferences.remove(AppConstants.userUniversityName);
    await _sharedPreferences.remove(AppConstants.userFacultyId);
    await _sharedPreferences.remove(AppConstants.userFacultyName);
    await _sharedPreferences.remove(AppConstants.userDepartmentId);
    await _sharedPreferences.remove(AppConstants.userDepartmentName);
    await _prefs.delete(key: AppConstants.token);
  }

  String? _getTrimmedString(String key) {
    final value = _sharedPreferences.getString(key);
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }

  Future<void> _saveNullableInt(String key, int? value) async {
    if (value == null) {
      await _sharedPreferences.remove(key);
      return;
    }
    await _sharedPreferences.setInt(key, value);
  }

  Future<void> _saveNullableString(String key, String? value) async {
    if (value == null || value.isEmpty) {
      await _sharedPreferences.remove(key);
      return;
    }
    await _sharedPreferences.setString(key, value);
  }
}
