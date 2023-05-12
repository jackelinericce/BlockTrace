import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/providers/register_order_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class ShowProfileDriverScreen extends ConsumerWidget {
  const ShowProfileDriverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var all = ref.watch(allTransportProvider);
    print('XDDDD');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conductores'),
      ),
      body: Container(
        child: all.when(
          // skipLoadingOnReload: true,
          data: (data) {
            print('get lsit drivers');
            List<RegisterTransportFormEntity> transports = data.map((doc) {
              return RegisterTransportFormEntity(
                id: doc['id'],
                name: doc["name"],
                lastName: doc["lastName"],
                ruc: doc['ruc'],
                address: doc['address'],
                number: doc['number'],
                licenseNumber: doc['licenseNumber'],
                categoryLicense: doc['categoryLicense'],
                email: doc['email'],
              );
            }).toList();

            if (transports.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('No hay ningun Transportista'),
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
                itemCount: transports.length,
                itemBuilder: (_, i) {
                  RegisterTransportFormEntity transportData = transports[i];

                  return ItemProfileDriverWidget(
                    transport: transportData,
                    onTap: () {
                      ref.context.push(
                        '/profileDriverInfo',
                        extra: transportData,
                      );
                    },
                  );
                });
          },
          error: (e, _) => Text('Hubo un error ${e.toString()}'),
          loading: () => const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          )),
        ),
      ),
    );
  }
}
