import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/providers/show_order_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class OrderScreen extends StatefulWidget {
  final int? initView;
  const OrderScreen({super.key, this.initView = 0});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
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
        title: const Text('Pedidos'),
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(icon: Icon(Icons.contacts), text: "En Proceso"),
            Tab(text: "Entregado"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          TabView01(),
          TabView02(),
        ],
      ),
    );
  }
}

class TabView01 extends ConsumerWidget {
  const TabView01({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var all = ref.watch(allOrdersProcesByClientIdProvider);

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

          List<RegisterOrderFormEntity> orders = data.map((doc) {
            Timestamp t = doc['createdAt'] as Timestamp;
            return RegisterOrderFormEntity(
              id: doc['id'] ?? '',
              state: doc['state'] ?? 'FAKE',
              product: doc['product'] ?? 'FAKE P',
              quantity: doc['quantity'] ?? 'FAKE Q',
              address: doc['address'] ?? 'FAKE Q',
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
                //   state: 'En camino',
                //   numberOrder: orders[i].id ?? 'id',
                //   estimatedDate: orders[i].date,
                //   address: orders[i].address,
                //   nameTransport: 'Pedro Gonzales',
                // );
                return ItemOrderInProcessWidget(
                  orderDate: orders[i].createdAt ?? '',
                  product: orders[i].product.toUpperCase(),
                  code: orders[i].id ?? 'id',
                  state: 'En camino',
                  numberOrder: orders[i].id ?? 'id',
                  estimatedDate: orders[i].date,
                  address: orders[i].address,
                  nameTransport: 'Tiago Solano',
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

class TabView02 extends ConsumerWidget {
  const TabView02({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var all = ref.watch(allOrdersFinalizedByClientIdProvider);
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

          List<RegisterOrderFormEntity> orders = data.map((doc) {
            Timestamp t = doc['createdAt'] as Timestamp;
            return RegisterOrderFormEntity(
              id: doc['id'] ?? '',
              state: doc['state'] ?? 'FAKE',
              product: doc['product'] ?? 'FAKE P',
              quantity: doc['quantity'] ?? 'FAKE Q',
              address: doc['address'] ?? 'FAKE Q',
              date: doc['date'],
              createdAt:
                  '${t.toDate().day}/${t.toDate().month}/${t.toDate().year}',
            );
          }).toList();

          return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (_, int i) {
                return ItemOrderDeliveredWidget(
                  orderDate: orders[i].createdAt ?? '',
                  product: orders[i].product.toUpperCase(),
                  code: orders[i].id ?? 'id',
                  state: 'Entregado',
                  numberOrder: orders[i].id ?? 'id',
                  estimatedDate: orders[i].date,
                  address: orders[i].address,
                  nameTransport: 'Tiago Solano',
                  nameClient: '',
                  propertyCard: '',
                  typePerishable: '',
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
