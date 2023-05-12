import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/providers/register_order_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class ShowProfileClientScreen extends ConsumerWidget {
  const ShowProfileClientScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var all = ref.watch(allClientProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: Container(
        child: all.when(
            data: (data) {
              List<RegisterClientFormEntity> clients = data.map((doc) {
                return RegisterClientFormEntity(
                  id: doc['id'],
                  name: doc["name"],
                  lastName: doc["lastName"],
                  address: doc["address"],
                  phone: doc["phone"],
                  dni: doc["dni"],
                  email: doc["email"],
                );
              }).toList();

              if (clients.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('No hay ningun Cliente'),
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
                  itemCount: clients.length,
                  itemBuilder: (_, i) {
                    RegisterClientFormEntity clientData = clients[i];

                    return ItemProfileClientWidget(
                      client: clientData,
                      onTap: () {
                        ref.context.push(
                          '/profileClientInfo',
                          extra: clientData,
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
