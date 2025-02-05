import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:select_text_field/select_text_field.dart';

void main() {
  testWidgets('SelectTextField displays text', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectTextField(
            options: ['Option 1', 'Option 2', 'Option 3'],
            label: 'Label',
            controller: TextEditingController(text: 'Test Text'),
          ),
        ),
      ),
    );

    // Verify the text is displayed
    expect(find.text('Test Text'), findsOneWidget);
  });
}
