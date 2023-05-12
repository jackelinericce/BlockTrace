import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> datos = [
      {
        'date': '21/02/223',
        'ubication': 'Monterrico, Distrito de Lima',
        'reference': '11:47 AM',
      },
      {
        'date': '21/02/2023',
        'ubication': 'Ctra. Panamericana Nte. 10, Puente Piedra',
        'reference': '13:21 pm',
      },
      {
        'date': '21/02/2023',
        'ubication': 'Ctra. Panamericana Nte., 15135',
        'reference': '15:02 pm',
      },
      {
        'date': '21/02/2023',
        'ubication': 'Ctra. Panamericana Nte., 02650',
        'reference': '16:48 pm',
      },
      {
        'date': '21/02/2023',
        'ubication': 'Ctra. Panamericana Nte., 02660',
        'reference': '18:37 pm',
      },
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Recorrido de envio'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: datos.length,
                  itemBuilder: (_, i) {
                    Map<String, String> dato = datos[i];
                    return ItemTimeLineHistoryOrderWidget(
                      date: dato['date']!,
                      ubication: dato['ubication']!,
                      reference: dato['reference']!,
                    );
                  }),
            ),
            const SizedBox(height: 20),
            Center(
              child: OutlinedButton(
                onPressed: () async {
                  Map<String, dynamic> mapa = {
                    "idOrden": 'wEp7Cl7R9vZc64nvdGNT',
                  };
                  // context.push('/rutaClient', extra: mapa);
                  context.push('/rutaClient', extra: mapa);
                },
                child: const Text('VER UBICACIÓN'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
