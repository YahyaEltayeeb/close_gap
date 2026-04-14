import 'package:close_gap/features/auth/register/domain/entities/profile_setup_entity.dart';

class RegisterRequestEntity {
  final String email;
  final String password;
  final String name;
  final String role;
  final ProfileSetupEntity? profileSetup;

  RegisterRequestEntity({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    this.profileSetup,
  });

  RegisterRequestEntity copyWith({
    String? email,
    String? password,
    String? name,
    String? role,
    ProfileSetupEntity? profileSetup,
  }) {
    return RegisterRequestEntity(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      role: role ?? this.role,
      profileSetup: profileSetup ?? this.profileSetup,
    );
  }
}
