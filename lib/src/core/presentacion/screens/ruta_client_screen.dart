import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RutaClientScreen extends StatefulWidget {
  final Map<String, dynamic>? mapa;
  const RutaClientScreen({super.key, this.mapa});

  @override
  State<RutaClientScreen> createState() => RutaClientScreenState();
}

class RutaClientScreenState extends State<RutaClientScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream =
        FirebaseFirestore.instance
            .collection('order')
            .doc(widget.mapa!["idOrden"])
            .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Recorrido '),
      ),
      body: StreamBuilder(
        stream: documentStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              SizedBox(
                width: size.width,
                child: GoogleMap(
                  mapType: MapType.normal,
                  mapToolbarEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      snapshot.data
                          ?.get('latOrigen'), //widget.mapa!["latOrigen"],
                      snapshot.data
                          ?.get('lngOrigen'), //widget.mapa!["lngOrigen"],
                    ),
                    zoom: 14.4746,
                  ),
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
    );
  }
}
