import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class ItemOrderDriverInProcessWidget extends StatelessWidget {
  final String product;
  final String code;
  final String state;
  final String numberOrder;
  final String orderDate;
  final String estimatedDate;
  final String address;
  final String nameTransport;
  final bool? isStart;
  const ItemOrderDriverInProcessWidget({
    super.key,
    required this.product,
    required this.code,
    required this.state,
    required this.numberOrder,
    required this.orderDate,
    required this.estimatedDate,
    required this.address,
    required this.nameTransport,
    this.isStart,
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
            Text('$product - $code'),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nº de envio:'),
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
                const Text('Cliente:'),
                Text(nameTransport),
                const SizedBox(height: 10),
                const Text('Lugar de destino:'),
                Text(address),
                const SizedBox(height: 10),
                Center(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('VER PERFIL DE INCIDENCIAS'),
                  ),
                ),
                Center(
                  child: OutlinedButton(
                    onPressed: () async {
                      if (isStart != true) {} // TODO:dash
                      try {
                        GeolocatorPlatform _geolocatorPlatform =
                            GeolocatorPlatform.instance;
                        Position pos =
                            await _geolocatorPlatform.getCurrentPosition();
                        CollectionReference db =
                            FirebaseFirestore.instance.collection('order');
                        await db.doc(numberOrder).update({
                          "latOrigen": pos.latitude,
                          "lngOrigen": pos.longitude,
                          "isStart": true,
                        });
                        Map<String, dynamic> mapa = {
                          "latOrigen": pos.latitude,
                          "lngOrigen": pos.longitude,
                          "idOrden": numberOrder,
                        };
                        context.push('/rutaDriver', extra: mapa);
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: (isStart == true)
                        ? const Text('VERR')
                        : const Text('COMENZAR'),
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
