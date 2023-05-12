import 'package:flutter/material.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';

class ItemProfileVehicleWidget extends StatelessWidget {
  const ItemProfileVehicleWidget({
    super.key,
    required this.vehicle,
    this.onTap,
  });

  final RegisterVehicleFormEntity vehicle;
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
          leading: const Icon(Icons.fire_truck_rounded),
          title: Text('PLACA: ${vehicle.propertyCard}'),
          subtitle: Text('SOAT: ${vehicle.hasSoat}'),
        ),
      ),
    );
  }
}
