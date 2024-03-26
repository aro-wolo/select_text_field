import 'package:flutter/material.dart';
import 'package:select_text_field/select_text_field.dart';

class SelectTextField extends StatefulWidget {
  /// List of the options that the buttom sheet will hold
  final List<String> options;

  /// display label of the text
  final String label;

  /// text endit controller
  final TextEditingController controller;

  /// what should happen when there is a change in the value of the text
  final Function(String)? onChanged;

  /// check for empty value
  final bool? required;

  /// add your custom validation
  final FormFieldValidator<String>? validator;

  const SelectTextField({
    super.key,
    required this.options,
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.required,
  });

  @override
  State<SelectTextField> createState() => _SelectTextFieldXState();
}

class _SelectTextFieldXState extends State<SelectTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: widget.controller,
            readOnly: true,
            onTap: () {
              _showModalBottomSheet(context);
            },
            validator: (widget.required == true) ? requiredValue : widget.validator,
            decoration: InputDecoration(
              labelText: widget.label,
              suffixIcon: IconButton(
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                onPressed: () {
                  _showModalBottomSheet(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalContent(
          title: widget.label,
          options: widget.options,
          controller: widget.controller,
          onChanged: widget.onChanged,
        );
      },
    );
  }

  String? requiredValue(value) {
    if (value == null || value.isEmpty) {
      return '${widget.label} is required';
    }
    return null;
  }
}
