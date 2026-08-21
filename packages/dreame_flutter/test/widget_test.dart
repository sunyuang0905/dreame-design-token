import 'package:dreame_flutter/dreame_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the public components', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DreameTheme.light(),
        home: Scaffold(
          body: ListView(
            children: [
              DreameButton(text: '确定', onPressed: () {}),
              const DreameInput(placeholder: '请输入'),
              const DreamePasswordInput(),
              const DreameOtpInput(),
              const DreameSelectInput(value: '家庭'),
              const DreameStepIndicator(current: 2),
            ],
          ),
        ),
      ),
    );
    expect(find.text('确定'), findsOneWidget);
    expect(find.text('2 / 5'), findsOneWidget);
    expect(find.text('家庭'), findsOneWidget);
  });
}
