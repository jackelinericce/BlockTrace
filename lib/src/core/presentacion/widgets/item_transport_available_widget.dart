import 'package:flutter/material.dart';

class ItemTransportAvailableWidget extends StatelessWidget {
  final String name;
  final String lastName;
  final String licenseNumber;
  final String categoryLicense;
  final Function()? onPressed;
  const ItemTransportAvailableWidget({
    super.key,
    required this.name,
    required this.lastName,
    required this.licenseNumber,
    required this.categoryLicense,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ExpansionTile(
          title: Text('$name $lastName'),
          children: [
            Container(
              child: Column(
                children: [
                  Table(
                    children: [
                      TableRow(
                        children: [
                          const Text('licencia: '),
                          Text(licenseNumber),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text('Categoría: '),
                          Text(categoryLicense),
                        ],
                      ),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: onPressed,
                    child: const Text('ASIGNAR'),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
