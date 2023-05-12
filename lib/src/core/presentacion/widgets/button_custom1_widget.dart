import 'package:flutter/material.dart';

class ButtonCustom1Widget extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const ButtonCustom1Widget({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 48,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.amber,
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
