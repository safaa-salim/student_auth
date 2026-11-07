
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/reset_password_request.dart';
import '../repositories/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository repository;

  AuthController({required this.repository});

  bool isLoading = false;
  UserModel? currentUser;
  String? errorMessage;

  Future<bool> login(LoginRequest request) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      currentUser = await repository.login(request);
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(RegisterRequest request) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      currentUser = await repository.register(request);
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sendPasswordResetCode(String identifier) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await repository.sendPasswordResetCode(identifier);
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> resetPassword(
    ResetPasswordRequest request,
  ) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await repository.resetPassword(request);
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
