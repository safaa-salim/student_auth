
import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../models/reset_password_request.dart';
import '../../utils/form_validators.dart';

class ResetPasswordPage extends StatefulWidget {
  final AuthController controller;
  final String identifier;

  const ResetPasswordPage({
    super.key,
    required this.controller,
    required this.identifier,
  });

  @override
  State<ResetPasswordPage> createState() =>
      _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await widget.controller.resetPassword(
      ResetPasswordRequest(
        identifier: widget.identifier,
        otp: _otpController.text.trim(),
        newPassword: _passwordController.text,
      ),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'تم تحديث كلمة المرور بنجاح'
              : widget.controller.errorMessage!,
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );

    if (success) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF604477);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3FA),
      appBar: AppBar(
        title: const Text('تعيين كلمة مرور جديدة'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.password_rounded,
                  size: 80,
                  color: primaryColor,
                ),
                const SizedBox(height: 20),

                const Text(
                  'تعيين كلمة مرور جديدة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 12),

                const Text(
                  'أدخل رمز التحقق المكوّن من 6 أرقام، '
                  'ثم اختر كلمة مرور جديدة.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 30),

                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  validator: FormValidators.validateOtp,
                  decoration: _decoration(
                    'رمز التحقق',
                    Icons.pin_outlined,
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: FormValidators.validatePassword,
                  decoration: _decoration(
                    'كلمة المرور الجديدة',
                    Icons.lock_outline,
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  validator: (value) =>
                      FormValidators.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  decoration: _decoration(
                    'تأكيد كلمة المرور',
                    Icons.lock_reset_outlined,
                    suffix: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword =
                              !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                AnimatedBuilder(
                  animation: widget.controller,
                  builder: (context, child) {
                    return ElevatedButton(
                      onPressed: widget.controller.isLoading
                          ? null
                          : _resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: widget.controller.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'تحديث كلمة المرور',
                              style: TextStyle(fontSize: 16),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(
    String label,
    IconData icon, {
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}
