import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/providers/show_order_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class ShowShipmentScreen extends ConsumerStatefulWidget {
  const ShowShipmentScreen({super.key});

  @override
  ShowShipmentScreenState createState() => ShowShipmentScreenState();
}

class ShowShipmentScreenState extends ConsumerState<ShowShipmentScreen>
    with TickerProviderStateMixin {
  int indexView = 0;
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(
      initialIndex: indexView,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordenes de envio'),
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(text: "En Proceso"),
            Tab(text: "Finalizado"),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: TabBarView(
            controller: _controller,
            children: [
              TabViewProgress(),
              TabViewFinalized(),
            ],
          ),
        ),
      ),
    );
  }
}

class TabViewProgress extends ConsumerWidget {
  const TabViewProgress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var all = ref.watch(allOrdersProcesProvider);
    return Container(
      child: all.when(
        data: (data) {
          List<RegisterOrderFormEntity> orders = data.map((doc) {
            return RegisterOrderFormEntity(
              id: doc['id'] ?? '',
              state: doc['state'] ?? 'FAKE',
              product: doc['product'] ?? 'FAKE P',
              quantity: doc['quantity'] ?? 'FAKE Q',
              date: doc['date'],
            );
          }).toList();

          if (orders.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('No hay ninguna Orden en PROCESO'),
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

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (_, int index) {
              RegisterOrderFormEntity orderData = orders[index];
              return ItemShipmentWidget(
                  title: orderData.product,
                  code: orderData.id!,
                  state: orderData.state!);
            },
          );
        },
        error: (e, _) => Text('Hubo un error ${e.toString()}'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class TabViewFinalized extends ConsumerWidget {
  const TabViewFinalized({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var all = ref.watch(allOrdersFinalizedProvider);
    return Container(
      child: all.when(
        data: (data) {
          List<RegisterOrderFormEntity> orders = data.map((doc) {
            return RegisterOrderFormEntity(
              id: doc['id'] ?? '',
              state: doc['state'] ?? 'FAKE',
              product: doc['product'] ?? 'FAKE P',
              quantity: doc['quantity'] ?? 'FAKE Q',
              date: doc['date'],
            );
          }).toList();

          if (orders.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('No hay ninguna Orden FINALIZADA'),
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

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (_, int index) {
              RegisterOrderFormEntity orderData = orders[index];
              return ItemShipmentWidget(
                  title: orderData.product,
                  code: orderData.id!,
                  state: orderData.state!);
            },
          );
        },
        error: (e, _) => Text('Hubo un error ${e.toString()}'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
