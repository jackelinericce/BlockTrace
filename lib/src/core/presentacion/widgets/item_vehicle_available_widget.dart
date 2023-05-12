import 'package:flutter/material.dart';

class ItemVehicleAvailableWidget extends StatelessWidget {
  final String id;
  final String propertyCard;
  final String numberOfAxes;
  final String long;
  final String width;
  final String hasSoat;
  final bool hasRefrigeration;
  final Function()? onPressed;
  const ItemVehicleAvailableWidget({
    super.key,
    required this.id,
    required this.propertyCard,
    required this.numberOfAxes,
    required this.long,
    required this.width,
    required this.hasSoat,
    required this.hasRefrigeration,
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
          title: Text('$propertyCard'),
          children: [
            Container(
              child: Column(
                children: [
                  Table(
                    children: [
                      TableRow(
                        children: [
                          const Text('Placa: '),
                          Text(propertyCard),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text('Nº de ejes: '),
                          Text(numberOfAxes),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text('Ancho: '),
                          Text(width),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text('Largo: '),
                          Text(long),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text('Refrigeración: '),
                          Text((hasRefrigeration) ? 'SI' : 'NO'),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text('Soat: '),
                          Text(hasSoat),
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
