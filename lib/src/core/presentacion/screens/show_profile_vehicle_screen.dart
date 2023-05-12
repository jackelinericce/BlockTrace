import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/providers/register_order_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class ShowProfileVehicleScreen extends ConsumerWidget {
  const ShowProfileVehicleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var all = ref.watch(allVehicleProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehiculos'),
      ),
      body: Container(
        child: all.when(
            data: (data) {
              var vehicles = data.map((doc) {
                return RegisterVehicleFormEntity(
                  id: doc["id"],
                  registrationNumber: doc["registrationNumber"],
                  propertyCard: doc["propertyCard"],
                  numberOfAxes: doc["numberOfAxes"],
                  width: doc["width"],
                  long: doc["long"],
                  hasSoat: doc["hasSoat"],
                  hasSure: doc["hasSure"],
                  hasRefrigeration: doc["hasRefrigeration"],
                );
              }).toList();

              if (vehicles.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('No hay ningun Vehiculo'),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ButtonCustom1Widget(
                        text: 'ATRAS',
                        onPressed: () {
                          ref.context.pop();
                        },
                      ),
                    ),
                  ],
                );
              }

              return ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (_, i) {
                    RegisterVehicleFormEntity vehicleData = vehicles[i];

                    return ItemProfileVehicleWidget(
                      vehicle: vehicleData,
                      onTap: () {
                        ref.context.push(
                          '/profileVehicleInfo',
                          extra: vehicleData,
                        );
                      },
                    );
                  });
            },
            error: (e, _) => Text('Hubo un error ${e.toString()}'),
            loading: () => const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
