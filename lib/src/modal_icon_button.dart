import 'package:flutter/material.dart';

class modalIconButton extends StatelessWidget {
  final Function() onTap;
  final IconData iconName;
  final Color bgColor;
  final Color? iconColor;

  const modalIconButton({
    super.key,
    required this.onTap,
    required this.iconName,
    required this.bgColor,
    this.iconColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: bgColor,
        ),
        child: Icon(
          iconName,
          size: 20.0,
          color: iconColor,
        ),
      ),
    );
  }
}
