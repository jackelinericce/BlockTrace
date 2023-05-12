import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';

import '../providers/perecedero_provider.dart';

class ShowPerishableWidget extends ConsumerWidget {
  const ShowPerishableWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PerecederoEntity> perecederos = ref.watch(perecederoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perecederos'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: perecederos.length,
          itemBuilder: (_, int i) {
            return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purpleAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Text(perecederos[i].name),
                leading: const Icon(Icons.balance_rounded),
              ),
            );
          },
        ),
      ),
    );
  }
}
