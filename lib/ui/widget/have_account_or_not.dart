import 'package:flutter/material.dart';

class HaveAccountOrNot extends StatelessWidget {
  const HaveAccountOrNot({
    Key? key,
    required this.content,
    required this.buttonName,
    required this.onPressed,
  }) : super(key: key);

  final String content;
  final String buttonName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          content,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(buttonName),
        ),
      ],
    );
  }
}
