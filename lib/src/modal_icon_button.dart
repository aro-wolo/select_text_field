import 'package:flutter/material.dart';
import 'package:select_text_field/select_text_field.dart';

class ModalIconButton extends StatelessWidget {
  final Function() onTap;
  final IconData iconName;

  const ModalIconButton({
    super.key,
    required this.onTap,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.darken(3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        icon: Icon(
          iconName,
          size: 20,
          color: Colors.grey,
        ),
        onPressed: onTap,
      ),
    );

    /* return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Icon(
          iconName,
          size: 20.0,
          color: Colors.orange,
        ),
      ),
    ); */
  }
}
