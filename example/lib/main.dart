import 'package:flutter/material.dart';
import 'package:select_text_field/select_text_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelectTextField Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  TextEditingController _controller = TextEditingController();
  String _selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SelectTextField Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectTextField(
              options: ['Option 1', 'Option 2', 'Option 3'],
              label: 'Select an option',
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Selected Option: $_selectedOption',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
