import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchCustom1Widget extends StatelessWidget {
  final String text;
  final bool value;
  final Widget? prefixIcon;
  final Function(bool)? onChanged;

  const SwitchCustom1Widget({
    super.key,
    required this.text,
    required this.value,
    this.onChanged,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: color.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: prefixIcon,
              ),
              Text(text),
            ],
          ),
          CupertinoSwitch(value: value, onChanged: onChanged)
        ],
      ),
    );
  }
}
