import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stotppub/src/core/presentacion/widgets/snackbar_widget.dart';

class IncidentRegisterScreen extends StatefulWidget {
  final String idDriver;
  const IncidentRegisterScreen({super.key, required this.idDriver});

  @override
  State<IncidentRegisterScreen> createState() => _IncidentRegisterScreenState();
}

class _IncidentRegisterScreenState extends State<IncidentRegisterScreen> {
  String titulo = '';
  String descripcion = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    var colorPrimary = color.primary;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Reportar incidente'),
      ),
      body: (isLoading == true)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        titulo = value;
                      });
                    },
                    decoration: InputDecoration(
                      disabledBorder: border.copyWith(
                        borderSide: BorderSide(color: colorPrimary),
                      ),
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: BorderSide(color: colorPrimary),
                      ),
                      focusColor: colorPrimary,
                      labelText: 'Incidente',
                      hintText: 'Ingrese nombre del incidente',
                      filled: true,
                      fillColor: colorPrimary.withOpacity(0.1),
                      // prefixIcon: prefixIcon,
                      prefixIconColor: colorPrimary,
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        descripcion = value;
                      });
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                      disabledBorder: border.copyWith(
                        borderSide: BorderSide(color: colorPrimary),
                      ),
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: BorderSide(color: colorPrimary),
                      ),
                      focusColor: colorPrimary,
                      labelText: 'Descripción',
                      hintText: 'Describa el incidente',
                      filled: true,
                      fillColor: colorPrimary.withOpacity(0.1),
                      // prefixIcon: prefixIcon,
                      prefixIconColor: colorPrimary,
                    ),
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
            CollectionReference db = FirebaseFirestore.instance
                .collection('order')
                .doc(widget.idDriver)
                .collection('incidents');
            await db.add({
              'titulo': titulo,
              'descripcion': descripcion,
            });
            setState(() {
              isLoading = false;
            });
            // var snacG = snackBarWidget(
            //     type: ContentType.success,
            //     title: 'Ok',
            //     message: 'La orden finalizó correctamente');
            // ScaffoldMessenger.of(context).showSnackBar(snacG);
            Navigator.pop(context);
          } catch (e) {
            print('ERRO PE CAUSA ${e.toString()}');
            setState(() {
              isLoading = false;
            });
            var snacE = snackBarWidget(
                title: 'Error', message: 'No se agrego el incidente');
            ScaffoldMessenger.of(context).showSnackBar(snacE);
          }
        },
        child: const Icon(
          Icons.save_rounded,
        ),
      ),
    );
  }
}
