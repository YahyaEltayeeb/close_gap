class RegisterRequestEntity {
  final String email;
  final String password;
  final String name;
  final String role;

  RegisterRequestEntity({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
  });
}