import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemOrderInProcessWidget extends StatelessWidget {
  final String product;
  final String code;
  final String state;
  final String numberOrder;
  final String orderDate;
  final String estimatedDate;
  final String address;
  final String nameTransport;
  const ItemOrderInProcessWidget({
    super.key,
    required this.product,
    required this.code,
    required this.state,
    required this.numberOrder,
    required this.orderDate,
    required this.estimatedDate,
    required this.address,
    required this.nameTransport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black12,
      ),
      child: ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(orderDate),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.share),
                )
              ],
            ),
            const SizedBox(height: 5),
            const Divider(height: 2),
            const SizedBox(height: 10),
            Text('$product - ${code.substring(0, 5)} '),
            Text(state),
          ],
        ),
        children: [
          Container(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nº de envío:'),
                        Text(numberOrder),
                      ],
                    ),
                    const Icon(Icons.copy),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Fecha de entrega estimada:'),
                Text(estimatedDate),
                const SizedBox(height: 10),
                const Text('Conductor asigando'),
                Text(nameTransport),
                const SizedBox(height: 10),
                const Text('Lugar de destino'),
                Text(address),
                const SizedBox(height: 10),
                // Center(
                //   child: OutlinedButton(
                //     onPressed: () {
                //       context.push('/orderHistoryClient');
                //     },
                //     child: const Text('REPORTE DE INCIDENCIAS'),
                //   ),
                // ),
                Center(
                  child: OutlinedButton(
                    onPressed: () async {
                      Map<String, dynamic> mapa = {
                        "idOrden": numberOrder,
                      };
                      // context.push('/rutaClient', extra: mapa);
                      context.push('/orderHistoryClient');
                    },
                    child: const Text('VER RECORRIDO DEL ENVÍO'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
