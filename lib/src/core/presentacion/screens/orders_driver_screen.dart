import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/providers/show_order_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class OrdersDriverScreen extends StatefulWidget {
  final int? initView;
  const OrdersDriverScreen({super.key, this.initView});

  @override
  State<OrdersDriverScreen> createState() => _OrdersDriverScreenState();
}

class _OrdersDriverScreenState extends State<OrdersDriverScreen>
    with TickerProviderStateMixin {
  int indexView = 0;
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    print('da ${widget.initView}');
    _controller = TabController(
      initialIndex: widget.initView!,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(text: "En Proceso"),
            Tab(text: "Entregado"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          TabOrdersProcesByDriver(),
          TabOrdersFinalizedByDriver(),
        ],
      ),
    );
  }
}

class TabOrdersFinalizedByDriver extends ConsumerWidget {
  const TabOrdersFinalizedByDriver({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var all = ref.watch(allOrdersFinalizedByDriverIdProvider);
    return Container(
      child: all.when(
        data: (data) {
          if (data.length == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('No tiene ninguna orden entregada'),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
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
          List<RegisterOrderFormEntity> orders = data.map((doc) {
            Timestamp t = doc['createdAt'] as Timestamp;
            return RegisterOrderFormEntity(
              id: doc['id'] ?? '',
              state: doc['state'] ?? 'FAKE',
              address: doc['address'] ?? 'FAKE',
              product: doc['product'] ?? 'FAKE P',
              quantity: doc['quantity'] ?? 'FAKE Q',
              date: doc['date'],
              createdAt:
                  '${t.toDate().day}/${t.toDate().month}/${t.toDate().year}',
            );
          }).toList();
          return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (_, int i) {
                // return ItemOrderDriverInProcessWidget(
                //   orderDate: orders[i].createdAt ?? '',
                //   product: orders[i].product,
                //   code: 'XXXXX',
                //   state: 'En Finalizado',
                //   numberOrder: orders[i].id ?? 'id',
                //   estimatedDate: orders[i].date,
                //   address: orders[i].address,
                //   nameTransport: 'Pedro Gonzales',
                // );
                return ItemOrderDriverDeliveredWidget(
                  product: orders[i].product,
                  code: 'XXXXX',
                  state: 'En Finalizado',
                  numberOrder: orders[i].id ?? 'id',
                  orderDate: orders[i].createdAt ?? '',
                  estimatedDate: orders[i].date,
                  address: orders[i].address,
                  nameClient: 'Rosario Del Campo Flores',
                  nameTransport: 'nameTransport',
                  propertyCard: 'propertyCard',
                  typePerishable: 'typePerishable',
                );

                //   return Widget(
                //   orderDate: orders[i].createdAt ?? '',
                //   product: orders[i].product,
                //   code: 'XXXXX',
                //   state: 'En Finalizado',
                //   numberOrder: orders[i].id ?? 'id',
                //   estimatedDate: orders[i].date,
                //   address: orders[i].address,
                //   nameTransport: 'Pedro Gonzales',
                // );
              });
        },
        error: (e, _) => Text('Hubo un error ${e.toString()}'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class TabOrdersProcesByDriver extends ConsumerWidget {
  const TabOrdersProcesByDriver({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var all = ref.watch(allOrdersProcesByDriverIdProvider);

    return Container(
      child: all.when(
        data: (data) {
          if (data.length == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('No tiene ninguna orden en PROCESO'),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
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

          List<RegisterOrderFormEntity> orders =
              data.map((QueryDocumentSnapshot<Object?> doc) {
            Timestamp t = doc['createdAt'] as Timestamp;

            return RegisterOrderFormEntity(
              id: doc['id'] ?? '',
              state: doc['state'] ?? 'FAKE',
              product: doc['product'] ?? 'FAKE P',
              quantity: doc['quantity'] ?? 'FAKE Q',
              address: doc['address'] ?? 'FAKE Q',
              date: doc['date'],
              isStart: doc.data().toString().contains('isStart')
                  ? doc.get('isStart')
                  : null,
              createdAt:
                  '${t.toDate().day}/${t.toDate().month}/${t.toDate().year}',
            );
          }).toList();

          return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (_, int i) {
                return ItemOrderDriverInProcessWidget(
                  orderDate: orders[i].createdAt ?? '',
                  product: orders[i].product,
                  code: orders[i].id!.substring(0, 5),
                  state: 'En camino',
                  numberOrder: orders[i].id ?? 'id',
                  estimatedDate: orders[i].date,
                  address: orders[i].address,
                  nameTransport: 'Rosario Del Campo Flores',
                  isStart: orders[i].isStart,
                );
              });
        },
        error: (e, _) => Text('Hubo un error ${e.toString()}'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
