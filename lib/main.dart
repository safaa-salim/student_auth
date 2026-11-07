
import 'package:flutter/material.dart';

import 'views/auth/login_page.dart';

void main() {
  runApp(const StudentAuthApp());
}

class StudentAuthApp extends StatelessWidget {
  const StudentAuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Authentication',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF604477),
        ),
        fontFamily: 'Arial',
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: LoginPage(),
    );
  }
}
