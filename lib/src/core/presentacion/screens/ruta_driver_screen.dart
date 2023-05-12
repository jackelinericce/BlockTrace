import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stotppub/src/core/presentacion/providers/show_order_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/snackbar_widget.dart';

class RutaDriverScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? mapa;
  const RutaDriverScreen({super.key, this.mapa});

  @override
  RutaDriverScreenState createState() => RutaDriverScreenState();
}

class RutaDriverScreenState extends ConsumerState<RutaDriverScreen> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final Set<Polyline> _polyline = {};
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream =
        FirebaseFirestore.instance
            .collection('order')
            .doc(widget.mapa!["idOrden"])
            .snapshots();
    print(widget.mapa!["latOrigen"]);
    print(widget.mapa!["lngOrigen"]);
    print(widget.mapa!["idOrden"]);

    return Scaffold(
      body: StreamBuilder(
        stream: documentStream, //_geolocatorPlatform.getCurrentPosition(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          // Position? positionCurrent = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          print('STREAMMMMMMMM');
          print(snapshot.data?.get('latOrigen'));
          print(snapshot.data?.get('lngOrigen'));
          print(snapshot.data?.get('lat'));
          print(snapshot.data?.get('lng'));
          CameraPosition _positionCamera = CameraPosition(
            target: LatLng(
              snapshot.data?.get('latOrigen'), //widget.mapa!["latOrigen"],
              snapshot.data?.get('lngOrigen'), //widget.mapa!["lngOrigen"],
            ),
            zoom: 14.4746,
          );

          // final Map<String, Polyline> polis;
          // final p1 = Polyline(
          //   polylineId: PolylineId('myRot1'),
          //   color: Colors.red,
          //   width: 5,
          //   startCap: Cap.roundCap,
          //   endCap: Cap.roundCap,
          //   points: [
          //     LatLng(
          //       widget.mapa!["latOrigen"],
          //       widget.mapa!["lngOrigen"],
          //     ),
          //   ],
          // );

          return Stack(
            children: [
              SizedBox(
                width: size.width,
                child: GoogleMap(
                  mapType: MapType.normal,
                  mapToolbarEnabled: true,
                  initialCameraPosition: _positionCamera,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  markers: {
                    Marker(
                      markerId: const MarkerId('MarkerId1'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure,
                      ),
                      position: LatLng(
                        snapshot.data?.get('latOrigen'),
                        snapshot.data?.get('lngOrigen'),
                      ),
                    ),
                    Marker(
                      markerId: const MarkerId('MarkerId2'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed,
                      ),
                      position: LatLng(
                        snapshot.data?.get('lat'),
                        snapshot.data?.get('lng'),
                      ),
                    ),
                  },
                  polylines: {
                    Polyline(
                      polylineId: PolylineId('myRot1'),
                      color: Colors.red,
                      width: 5,
                      startCap: Cap.roundCap,
                      endCap: Cap.roundCap,
                      points: [
                        LatLng(
                          snapshot.data
                              ?.get('latOrigen'), //widget.mapa!["latOrigen"],
                          snapshot.data
                              ?.get('lngOrigen'), //widget.mapa!["lngOrigen"],
                        ),
                        LatLng(
                          snapshot.data
                              ?.get('lat'), //widget.mapa!["latOrigen"],
                          snapshot.data
                              ?.get('lng'), //widget.mapa!["lngOrigen"],
                        ),
                      ],
                    )
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              try {
                var resDialog = await showDialog<bool>(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Terminar orden'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            SizedBox(height: 15),
                            Text('¿Está seguro de finalizar la orden?'),
                            SizedBox(height: 15),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(false),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.pop(true),
                            child: const Text('Ok'),
                          )
                        ],
                      );
                    });

                if (resDialog == true) {
                  CollectionReference db =
                      FirebaseFirestore.instance.collection('order');

                  await db.doc(widget.mapa!["idOrden"]).update({
                    "state": "TERMINADO",
                  });
                  setState(() {
                    isLoading = false;
                  });
                  ref.refresh(allOrdersFinalizedByDriverIdProvider);
                  ref.refresh(allOrdersProcesByDriverIdProvider);

                  ref.context.pop();
                }
              } catch (e) {
                setState(() {
                  isLoading = false;
                });
                var snacE = snackBarWidget(
                    title: 'Error', message: 'No se actualizó la orden');
                ScaffoldMessenger.of(ref.context).showSnackBar(snacE);
              }
            },
            child: (isLoading == true)
                ? const CircularProgressIndicator()
                : const Icon(Icons.done_outline_sharp),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () {
              ref.context
                  .push('/incidenteRegister', extra: widget.mapa!["idOrden"]);
            },
            child: const Icon(Icons.report_problem_rounded),
          ),
        ],
      ),
    );
  }
}
