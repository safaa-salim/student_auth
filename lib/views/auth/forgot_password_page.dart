
import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  final AuthController controller;

  const ForgotPasswordPage({
    super.key,
    required this.controller,
  });

  @override
  State<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;

    final identifier = _identifierController.text.trim();

    final success = await widget.controller
        .sendPasswordResetCode(identifier);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال رمز التحقق بنجاح'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResetPasswordPage(
            controller: widget.controller,
            identifier: identifier,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.controller.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF604477);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3FA),
      appBar: AppBar(
        title: const Text('استعادة كلمة المرور'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.lock_reset_rounded,
                    size: 85,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 25),

                  const Text(
                    'هل نسيت كلمة المرور؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'أدخل بريدك الإلكتروني أو رقمك الأكاديمي '
                    'لنساعدك على استعادة حسابك.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 35),

                  TextFormField(
                    controller: _identifierController,
                    validator:
                        FormValidators.validateLoginIdentifier,
                    decoration: InputDecoration(
                      labelText: 'البريد أو الرقم الأكاديمي',
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
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
                            : _sendCode,
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
                                'إرسال رمز التحقق',
                                style: TextStyle(fontSize: 16),
                              ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('العودة لتسجيل الدخول'),
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
