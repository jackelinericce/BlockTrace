import 'package:flutter/material.dart';

class ItemOptionMenu extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onClick;
  const ItemOptionMenu({
    super.key,
    required this.text,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Center(
          child: ListTile(
            title: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
            leading: icon,
          ),
        ),
      ),
    );
  }
}
