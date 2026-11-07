
class FormValidators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الاسم الكامل مطلوب';
    }

    if (value.trim().length < 3) {
      return 'يجب ألا يقل الاسم عن 3 أحرف';
    }

    return null;
  }

  static String? validateAcademicId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرقم الأكاديمي مطلوب';
    }

    if (!RegExp(r'^\d{9,10}$').hasMatch(value.trim())) {
      return 'الرقم الأكاديمي يجب أن يتكون من 9 أو 10 أرقام';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }

    return null;
  }

  static String? validateLoginIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'أدخلي البريد أو الرقم الأكاديمي';
    }

    if (value.trim().length < 5) {
      return 'يجب ألا يقل الإدخال عن 5 خانات';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (value.length < 8) {
      return 'كلمة المرور يجب ألا تقل عن 8 أحرف';
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return 'يجب أن تحتوي كلمة المرور على رقم';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'يجب أن تحتوي على حرف إنجليزي كبير';
    }

    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (value.length < 6) {
      return 'كلمة المرور يجب ألا تقل عن 6 أحرف';
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String password,
  ) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }

    if (value != password) {
      return 'كلمتا المرور غير متطابقتين';
    }

    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'رمز التحقق مطلوب';
    }

    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'رمز التحقق يجب أن يتكون من 6 أرقام';
    }

    return null;
  }
}
