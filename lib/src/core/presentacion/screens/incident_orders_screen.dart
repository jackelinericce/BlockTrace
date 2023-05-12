import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';

class IncidentOrdersScreen extends StatefulWidget {
  const IncidentOrdersScreen({super.key});

  @override
  State<IncidentOrdersScreen> createState() => _IncidentOrdersScreenState();
}

class _IncidentOrdersScreenState extends State<IncidentOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordenes'),
      ),
      body: Container(
          child: FutureBuilder(
        future: getListAllOrdersByIdCLient(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RegisterOrderFormEntity>> snapshot) {
          List<RegisterOrderFormEntity>? d = snapshot.data;
          if (d == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: d.length,
            itemBuilder: (BuildContext context, int index) {
              var ord = d[index];
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
                          Text(ord.date),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.share),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(height: 2),
                      const SizedBox(height: 10),
                      Text('${ord.product} - ${ord.id!.substring(0, 5)} '),
                      Text('${ord.state}')
                      // Text(ord.id!),
                    ],
                  ),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Center(
                            child: OutlinedButton(
                              onPressed: () async {
                                Map<String, dynamic> mapa = {
                                  "idOrden": ord.id!,
                                };
                                context.push('/incident', extra: mapa);
                              },
                              child: const Text('VER INCIDENTE'),
                            ),
                          ),
                          const SizedBox(height: 15)
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      )),
    );
  }

  Future<List<RegisterOrderFormEntity>> getListAllOrdersByIdCLient() async {
    try {
      CollectionReference db = FirebaseFirestore.instance.collection("order");
      final storage = LocalStorage('my_data.json');
      String idClient = await storage.getItem('idUser');
      var orders = await db
          // .where('state', isEqualTo: 'PROCESO')
          .where('idClient', isEqualTo: idClient)
          .get();
      List<RegisterOrderFormEntity> ordenes = orders.docs.map((doc) {
        return RegisterOrderFormEntity(
          id: doc['id'] ?? '',
          product: doc['product'] ?? '',
          date: doc['date'] ?? '',
          state: doc['state'] ?? '',
        );
      }).toList();
      return ordenes;
    } catch (e) {
      return [];
    }
  }
}
