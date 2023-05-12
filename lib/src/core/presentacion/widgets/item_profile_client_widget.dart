import 'package:flutter/material.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';

class ItemProfileClientWidget extends StatelessWidget {
  const ItemProfileClientWidget({
    super.key,
    required this.client,
    this.onTap,
  });

  final RegisterClientFormEntity client;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: const Icon(Icons.person_4),
          title: Text(client.name),
          subtitle: Text(client.lastName),
        ),
      ),
    );
  }
}
