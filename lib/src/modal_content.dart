import 'package:flutter/material.dart';
import 'package:select_text_field/select_text_field.dart';

class ModalContent extends StatefulWidget {
  final List<dynamic> options;
  final String title;
  final dynamic selectedValue;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? onMessage;

  const ModalContent({
    super.key,
    required this.options,
    required this.title,
    this.onChanged,
    this.onMessage,
    this.selectedValue,
  });

  @override
  State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  final FocusNode _focusNode = FocusNode();
  dynamic _selectedOption;
  String _searchValue = "";
  bool _searchButtonClicked = false;

  List<dynamic> _filteredOptions = [];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _filteredOptions = widget.options;

    if (widget.options is List<Map<String, dynamic>>) {
      dynamic selectedOption;
      for (var option in widget.options) {
        if ("${option['key']}" == widget.selectedValue.toString()) {
          selectedOption = option;
          break;
        }
      }

      if (selectedOption != null) {
        _selectedOption = selectedOption;
      }
    } else {
      _selectedOption = widget.selectedValue;
    }
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

    if (_searchButtonClicked) {
      setState(() {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
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
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _searchButtonClicked
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.search,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .darken(10)),
                            ),
                            Expanded(
                              child: TextField(
                                focusNode: _focusNode,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Search for ${widget.title}..',
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(width: 0, color: Colors.grey),
                                  ),
                                  hintStyle:
                                      TextStyle(color: Colors.grey.withOpacity(.75)),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _searchValue = value;
                                    if (widget.options is List<Map<String, dynamic>>) {
                                      _filteredOptions =
                                          (widget.options as List<Map<String, dynamic>>)
                                              .where((item) {
                                        return item['title']
                                            .toLowerCase()
                                            .contains(value.toLowerCase());
                                      }).toList();
                                      _filteredOptions.map((item) {
                                        return {
                                          'title': item['title'],
                                          'key': item['key'],
                                        };
                                      }).toList();
                                    } else {
                                      _filteredOptions = widget.options
                                          .where(
                                            (item) => item.toLowerCase().contains(
                                                  value.toLowerCase(),
                                                ),
                                          )
                                          .toList();
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      : Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
                Row(
                  children: [
                    Visibility(
                      visible: widget.options.length > 15 && !_searchButtonClicked,
                      child: ModalIconButton(
                        onTap: () {
                          setState(() {
                            _searchButtonClicked = true;
                          });
                        },
                        iconName: Icons.search,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ModalIconButton(
                      onTap: () => Navigator.of(context).pop(),
                      iconName: Icons.close,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 8, 15),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: ListView.builder(
                  itemCount: _filteredOptions.length,
                  itemBuilder: (context, index) {
                    final result = _filteredOptions[index];
                    final highlightedOption = _getHighlightedText(
                      _filteredOptions[index],
                      _searchValue,
                    );
                    //print("widget.selectedValue=${widget.selectedValue}");
                    return RadioListTile(
                      title: Text.rich(highlightedOption),
                      //value: _isSimpleList ? result : result['key'],
                      value: result,
                      //groupValue: _selectedValue,
                      groupValue: _selectedOption,
                      // groupValue: widget.selectedValue,
                      //groupValue: widget.selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                        widget.onMessage!(value);

                        /* if (_isSimpleList) {
                          widget.onChanged?.call(value);
                        } else {
                          widget.onChanged?.call(value);
                        } */
                        widget.onChanged?.call(value);

                        Future.delayed(const Duration(milliseconds: 200), () {
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _getHighlightedText(dynamic text, String query) {
    String nText;
    if (text is String) {
      nText = text;
    } else {
      nText = text['title'];
    }
    if (query.isEmpty) {
      return TextSpan(text: nText);
    }

    final matches = RegExp(query, caseSensitive: false).allMatches(nText);
    if (matches.isEmpty) {
      return TextSpan(text: nText);
    }

    List<TextSpan> spans = [];
    int start = 0;
    for (Match match in matches) {
      final beforeMatch = nText.substring(start, match.start);
      final matchText = nText.substring(match.start, match.end);
      spans.add(TextSpan(text: beforeMatch));
      spans.add(TextSpan(
        text: matchText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          //color: Colors.purpleAccent,
        ),
      ));
      start = match.end;
    }
    spans.add(TextSpan(text: nText.substring(start)));

    return TextSpan(children: spans);
  }
}
