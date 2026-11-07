
class LoginRequest {
  final String identifier;
  final String password;
  final bool rememberMe;

  const LoginRequest({
    required this.identifier,
    required this.password,
    this.rememberMe = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'password': password,
      'rememberMe': rememberMe,
    };
  }
}
