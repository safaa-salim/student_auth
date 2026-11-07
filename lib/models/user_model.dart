
class UserModel {
  final String fullName;
  final String academicId;
  final String email;

  const UserModel({
    required this.fullName,
    required this.academicId,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] as String,
      academicId: json['academicId'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'academicId': academicId,
      'email': email,
    };
  }
}
