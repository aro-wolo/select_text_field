import 'package:flutter/material.dart';
import 'package:select_text_field/select_text_field.dart';

class SelectTextField extends StatefulWidget {
  final List<dynamic> options;
  final TextEditingController? controller;
  final String label;
  final dynamic selectedValue;
  final Function(dynamic)? onChanged;
  final bool? required;
  final FormFieldValidator<String>? validator;
  final String? displayValue;

  const SelectTextField({
    super.key,
    required this.options,
    required this.label,
    this.validator,
    this.onChanged,
    this.required,
    this.selectedValue,
    this.controller,
    this.displayValue,
  });

  @override
  State<SelectTextField> createState() => SelectTextFieldState();
}

class SelectTextFieldState extends State<SelectTextField> {
  late TextEditingController _internalController;
  late bool _isSimpleList;
  dynamic _selectedValue;

  @override
  void initState() {
    super.initState();
    newMethod();
  }

  void newMethod() {
    _isSimpleList = widget.options.isEmpty || widget.options[0] is! Map<String, dynamic>;

    String initialDisplayTitle = '';
    if (widget.displayValue != null) {
      initialDisplayTitle = widget.displayValue!;
    } else if (widget.selectedValue != null) {
      initialDisplayTitle = _getDisplayValue(widget.selectedValue);
    } else if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      initialDisplayTitle = _getDisplayValue(widget.controller!.text);
    }

    _internalController = TextEditingController(text: initialDisplayTitle);

    if (widget.controller != null && widget.controller!.text.isEmpty) {
      widget.controller!.text = initialDisplayTitle;
    }

    _selectedValue = widget.selectedValue ?? widget.controller?.text;
  }

  String _getDisplayValue(dynamic value) {
    if (_isSimpleList) {
      return value;
    } else {
      for (var option in widget.options) {
        if ("${option['key']}" == value.toString()) {
          return option['title'];
        }
      }
      return '';
    }
  }

  @override
  void dispose() {
    _internalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: _internalController,
            readOnly: true,
            onTap: () {
              _showModalBottomSheet(context);
            },
            validator: (widget.required == true) ? requiredValue : widget.validator,
            decoration: InputDecoration(
              labelText: widget.label,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
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

  void _handleMessage(dynamic message) {
    setState(() {
      _selectedValue = message;
      widget.onChanged!(message);
    });
  }

  dynamic getSelectedValue() {
    return _selectedValue;
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalContent(
          title: widget.label,
          options: widget.options,
          //selectedValue: widget.selectedValue ?? widget.controller?.text,
          selectedValue: _selectedValue,
          onMessage: _handleMessage,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
            setState(() {
              _selectedValue = _isSimpleList ? value : value['key'];
              final displayValue = _getDisplayValue(_isSimpleList ? value : value['key']);
              if (widget.controller != null) {
                widget.controller!.text = displayValue;
              }
              _internalController.text = displayValue;
              /* print("internal=$_selectedValue");
              print("internal-onch-value=$value"); */
            });
          },
          /*       onChanged: (value) {
            setState(() {
              _selectedValue = _isSimpleList ? value : value['key'];
              final displayValue = _getDisplayValue(_isSimpleList ? value : value['key']);
              if (widget.controller != null) {
                widget.controller!.text = displayValue;
              }
              _internalController.text = displayValue;
            });
            // Update selectedValue in the parent
            if (widget.onChanged != null) {
              widget.onChanged!(_selectedValue);
            }
          }, */
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
