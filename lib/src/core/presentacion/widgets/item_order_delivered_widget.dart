import 'package:flutter/material.dart';

class ItemOrderDeliveredWidget extends StatelessWidget {
  final String product;
  final String code;
  final String state;
  final String numberOrder;
  final String orderDate;
  final String estimatedDate;
  final String address;
  final String nameClient;
  final String nameTransport;
  final String propertyCard;
  final String typePerishable;
  const ItemOrderDeliveredWidget({
    super.key,
    required this.product,
    required this.code,
    required this.state,
    required this.numberOrder,
    required this.orderDate,
    required this.estimatedDate,
    required this.address,
    required this.nameClient,
    required this.nameTransport,
    required this.propertyCard,
    required this.typePerishable,
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
        onExpansionChanged: (value) {
          print('value essssss $value');
        },
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
            const Text('En sucursal'),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                const Text('Conductor asigando'),
                Text(nameTransport),
                const SizedBox(height: 10),
                const Text('Lugar de destino'),
                Text(address),
                // const SizedBox(height: 10),
                // const Text('Cliente'),
                // Text(nameClient),
                // const SizedBox(height: 10),
                // const Text('Transportista'),
                // Text(nameTransport),
                // const SizedBox(height: 10),
                // const Text('Placa de camión'),
                // Text(propertyCard),
                // const SizedBox(height: 10),
                // const Text('Tipo de perecedero'),
                // Text(typePerishable),
                const SizedBox(height: 10),
                Center(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('VER RECORRIDO DEL ENVÍO'),
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
