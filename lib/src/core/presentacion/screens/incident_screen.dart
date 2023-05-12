import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class IncidentScreen extends StatelessWidget {
  const IncidentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidentes'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getIncidents(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          List<Map<String, dynamic>>? datos = snapshot.data;
          if (datos == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            child: ListView.builder(
              itemCount: datos.length,
              itemBuilder: (_, int index) {
                Map<String, dynamic> incident = datos[index];
                return ItemIncidentWidget(name: incident['titulo']);
              },
            ),
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getIncidents() async {
    try {
      CollectionReference db = FirebaseFirestore.instance
          .collection("order")
          .doc('wEp7Cl7R9vZc64nvdGNT')
          .collection('incidents');
      QuerySnapshot<Object?> incedents = await db.get();
      List<Map<String, dynamic>> datos = incedents.docs.map((doc) {
        return {
          'titulo': doc.get('titulo'),
          'descripcion': doc.get('descripcion'),
        };
      }).toList();
      return datos;
    } catch (e) {
      return [];
    }
  }
}
