
import 'package:flutter_test/flutter_test.dart';
import 'package:student_auth/main.dart';

void main() {
  testWidgets('Student Auth app test', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentAuthApp());

    expect(find.text('تسجيل الدخول'), findsOneWidget);
  });
}
