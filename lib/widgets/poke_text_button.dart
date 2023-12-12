import 'package:flutter/material.dart';

class PokeTextButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;

  const PokeTextButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        alignment: Alignment.bottomLeft
      ),
      child: child,
    );
  }
}
