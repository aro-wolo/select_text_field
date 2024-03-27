import 'package:flutter/material.dart';
import 'package:select_text_field/select_text_field.dart';
import 'package:tinycolor2/tinycolor2.dart';

class ModalContent extends StatefulWidget {
  final List<String> options;
  final TextEditingController controller;
  final String title;
  final Function(String)? onChanged;

  const ModalContent({
    super.key,
    required this.options,
    required this.controller,
    required this.title,
    this.onChanged,
  });

  @override
  State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  final FocusNode _focusNode = FocusNode();
  String? _selectedItem;
  String _searchValue = "";
  bool _serachButtonClicked = false;

  List<String> _filteredOptions = [];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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
    var _bColor = TinyColor.fromColor(
            Theme.of(context).bottomSheetTheme.backgroundColor ?? Colors.white)
        .darken(8)
        .color;
    var _bColor2 = TinyColor.fromColor(
            Theme.of(context).bottomSheetTheme.backgroundColor ?? Colors.white)
        .darken(3)
        .color;
    var _iColor = TinyColor.fromColor(
            Theme.of(context).bottomSheetTheme.backgroundColor ?? Colors.white)
        .darken(50)
        .color;

    if (_serachButtonClicked) {
      setState(() {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    }
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
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: _bColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _serachButtonClicked
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.search, color: Colors.grey),
                            ),
                            Expanded(
                              child: TextField(
                                focusNode: _focusNode,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Search for ${widget.title}..',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(width: 0, color: _bColor)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 0, color: _bColor),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _searchValue = value;
                                    _filteredOptions = widget.options
                                        .where((item) => item
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                        .toList();
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      : Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
                Row(
                  children: [
                    Visibility(
                      visible: widget.options.length > 15 && !_serachButtonClicked,
                      child: modalIconButton(
                        bgColor: _bColor2,
                        iconColor: _iColor,
                        onTap: () {
                          setState(() {
                            _serachButtonClicked = true;
                          });
                        },
                        iconName: Icons.search,
                      ),
                    ),
                    const SizedBox(width: 8),
                    modalIconButton(
                      bgColor: _bColor2,
                      iconColor: _iColor,
                      onTap: () => Navigator.of(context).pop(),
                      iconName: Icons.close,
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                    setState(() {
                      _selectedItem = value;
                    });
                    widget.controller.text = value!;
                    widget.onChanged?.call(value);
                    Future.delayed(Duration(milliseconds: 250), () {
                      Navigator.pop(context);
                    });
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
