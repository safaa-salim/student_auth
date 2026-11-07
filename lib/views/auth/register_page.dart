
import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../models/register_request.dart';
import '../../utils/form_validators.dart';

class RegisterPage extends StatefulWidget {
  final AuthController controller;

  const RegisterPage({
    super.key,
    required this.controller,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _academicIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedRules = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptedRules) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب الموافقة على اللوائح أولًا'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final success = await widget.controller.register(
      RegisterRequest(
        fullName: _nameController.text.trim(),
        academicId: _academicIdController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'تم إنشاء الحساب بنجاح'
              : widget.controller.errorMessage!,
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );

    if (success) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _academicIdController.dispose();
    _emailController.dispose();
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
        title: const Text('إنشاء حساب'),
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
                  Icons.person_add_alt_1_rounded,
                  size: 65,
                  color: primaryColor,
                ),
                const SizedBox(height: 15),
                const Text(
                  'إنشاء حساب طلابي جديد',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 25),

                TextFormField(
                  controller: _nameController,
                  validator: FormValidators.validateName,
                  decoration: _decoration(
                    'الاسم الكامل',
                    Icons.person_outline,
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _academicIdController,
                  keyboardType: TextInputType.number,
                  validator: FormValidators.validateAcademicId,
                  decoration: _decoration(
                    'الرقم الأكاديمي',
                    Icons.badge_outlined,
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.validateEmail,
                  decoration: _decoration(
                    'البريد الجامعي',
                    Icons.email_outlined,
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: FormValidators.validatePassword,
                  decoration: _decoration(
                    'كلمة المرور',
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

                const SizedBox(height: 18),

                CheckboxListTile(
                  value: _acceptedRules,
                  activeColor: primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text(
                    'أوافق على اللوائح والشروط الطلابية',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _acceptedRules = value ?? false;
                    });
                  },
                ),

                const SizedBox(height: 20),

                AnimatedBuilder(
                  animation: widget.controller,
                  builder: (context, child) {
                    return ElevatedButton(
                      onPressed: widget.controller.isLoading
                          ? null
                          : _register,
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
                              'إنشاء الحساب',
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
