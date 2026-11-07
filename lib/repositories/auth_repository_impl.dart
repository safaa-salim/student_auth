
import '../models/user_model.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/reset_password_request.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  UserModel? _registeredUser;
  String? _registeredPassword;
  String? _resetCode;
  String? _resetIdentifier;

  @override
  Future<UserModel> login(LoginRequest request) async {
    await Future.delayed(const Duration(seconds: 2));

    if (_registeredUser == null) {
      throw Exception('لا يوجد حساب مسجل');
    }

    if (request.identifier != _registeredUser!.email &&
        request.identifier != _registeredUser!.academicId) {
      throw Exception('بيانات الدخول غير صحيحة');
    }

    if (request.password != _registeredPassword) {
      throw Exception('كلمة المرور غير صحيحة');
    }

    return _registeredUser!;
  }

  @override
  Future<UserModel> register(RegisterRequest request) async {
    await Future.delayed(const Duration(seconds: 2));

    _registeredUser = UserModel(
      fullName: request.fullName,
      academicId: request.academicId,
      email: request.email,
    );

    _registeredPassword = request.password;

    return _registeredUser!;
  }

  @override
  Future<void> sendPasswordResetCode(String identifier) async {
    await Future.delayed(const Duration(seconds: 2));

    if (_registeredUser == null ||
        (identifier != _registeredUser!.email &&
         identifier != _registeredUser!.academicId)) {
      throw Exception('الحساب غير موجود');
    }

    _resetIdentifier = identifier;
    _resetCode = '123456';
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    await Future.delayed(const Duration(seconds: 2));

    if (request.identifier != _resetIdentifier ||
        request.otp != _resetCode) {
      throw Exception('رمز التحقق أو بيانات الحساب غير صحيحة');
    }

    _registeredPassword = request.newPassword;
    _resetCode = null;
    _resetIdentifier = null;
  }
}
