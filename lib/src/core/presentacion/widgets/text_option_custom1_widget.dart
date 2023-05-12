import 'package:flutter/material.dart';

class TextOptionCustom1Widget extends StatelessWidget {
  final String text;
  final String value;
  final String titleOption;
  final List<String> valueOption;
  final Function(String?)? onChanged;
  final Widget? prefixIcon;

  const TextOptionCustom1Widget({
    super.key,
    required this.text,
    required this.titleOption,
    required this.value,
    this.prefixIcon,
    required this.valueOption,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () async {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.2,
                maxChildSize: 0.75,
                expand: false,
                builder: (_, controller) => Column(
                  children: [
                    Icon(
                      Icons.remove,
                      color: Colors.grey[600],
                    ),
                    Text(titleOption),
                    Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: valueOption.length,
                        itemBuilder: (_, index) {
                          var data = valueOption[index];
                          return Card(
                            child: Row(
                              children: [
                                Radio<String>(
                                  // title: Text(data),
                                  value: data,
                                  groupValue: value,
                                  onChanged: onChanged,
                                ),
                                Text(data),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      child: Container(
        height: 64,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color.primary.withOpacity(0.1),
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8, left: 8),
              child: prefixIcon,
            ),
            (text == '') ? Text(text) : Text('Categoría: $value')
          ],
        ),
      ),
    );
  }
}
