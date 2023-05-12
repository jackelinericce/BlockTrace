import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowProfilesScreen extends StatelessWidget {
  const ShowProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar Perfiles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ItemProfileMaintenanceWidget(
              title: 'Transportistas',
              onTap: () {
                context.push('/showProfileDriver');
              },
            ),
            const SizedBox(height: 15),
            ItemProfileMaintenanceWidget(
              title: 'Clientes',
              onTap: () {
                context.push('/showProfileClient');
              },
            ),
            const SizedBox(height: 15),
            ItemProfileMaintenanceWidget(
              title: 'Vehiculos',
              onTap: () {
                context.push('/showProfileVehicle');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ItemProfileMaintenanceWidget extends StatelessWidget {
  const ItemProfileMaintenanceWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color.onSecondary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Icon(Icons.online_prediction_sharp),
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
