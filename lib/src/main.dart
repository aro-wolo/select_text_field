import 'package:flutter/material.dart';

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

class ModalContent extends StatefulWidget {
  final List<String> options;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const ModalContent({
    super.key,
    required this.options,
    required this.controller,
    this.onChanged,
  });

  @override
  State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  String? _selectedItem;
  String _searchValue = "";

  List<String> _filteredOptions = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedItem = widget.controller.text;
      _filteredOptions = widget.options;
    });
  }

  @override
  Widget build(BuildContext context) {
    double heightFactor = .6;
    final MediaQueryData mq = MediaQueryData.fromView(View.of(context));
    final double topObstructions = mq.viewPadding.top;
    final double bottomObstructions = mq.viewPadding.bottom;
    final double keyboardHeight = mq.viewInsets.bottom;
    final double deviceHeight = mq.size.height;
    if (widget.options.length < 4) {
      heightFactor = .3;
    } else if (widget.options.length < 5) {
      heightFactor = .4;
    } else if (widget.options.length < 7) {
      heightFactor = .5;
    } else if (widget.options.length < 10) {
      heightFactor = .6;
    } else if (widget.options.length < 15) {
      heightFactor = .7;
    } else if (widget.options.length < 25) {
      heightFactor = .8;
    } else if (widget.options.length > 25) {
      heightFactor = .85;
    }

    final double modalHeight = (deviceHeight * heightFactor) + keyboardHeight;
    final bool isFullHeight = modalHeight >= deviceHeight;
    return Container(
      padding: EdgeInsets.only(
        top: isFullHeight ? topObstructions : 0,
        bottom: keyboardHeight + bottomObstructions,
      ),
      constraints: BoxConstraints(
        maxHeight: isFullHeight ? double.infinity : modalHeight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _filteredOptions.length > 15
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchValue = value;
                        _filteredOptions = widget.options
                            .where((item) =>
                                item.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredOptions.length,
              itemBuilder: (context, index) {
                final highlightedOption =
                    _getHighlightedText(_filteredOptions[index], _searchValue);
                return RadioListTile(
                  title: Text.rich(highlightedOption),
                  value: _filteredOptions[index],
                  groupValue: _selectedItem,
                  onChanged: (value) {
                    widget.controller.text = value!;
                    widget.onChanged?.call(value);
                    setState(() {
                      _selectedItem = value;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _getHighlightedText(String text, String query) {
    if (query.isEmpty) return TextSpan(text: text);

    final matches = RegExp(query, caseSensitive: false).allMatches(text);
    if (matches.isEmpty) return TextSpan(text: text);

    List<TextSpan> spans = [];
    int start = 0;
    for (Match match in matches) {
      final beforeMatch = text.substring(start, match.start);
      final matchText = text.substring(match.start, match.end);
      spans.add(TextSpan(text: beforeMatch));
      spans.add(TextSpan(
        text: matchText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.purpleAccent,
        ),
      ));
      start = match.end;
    }
    spans.add(TextSpan(text: text.substring(start)));

    return TextSpan(children: spans);
  }
}
