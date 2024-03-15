import 'package:flutter/material.dart';
import 'package:select_text_field/select_text_field.dart';

/// Complete Simple Example
class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  // simple check

  // form key for validation
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> _genderList = ["Male", "Female"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Text Field"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectTextField(
              options: _genderList,
              label: 'Gender',
              controller: txtController,
            )
          ],
        ),
      ),
    );
  }
}
