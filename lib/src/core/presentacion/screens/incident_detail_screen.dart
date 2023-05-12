import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stotppub/src/core/presentacion/widgets/button_custom1_widget.dart';

class IncidentDetailScreen extends StatelessWidget {
  const IncidentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(-9.484502147032755, -78.27551019958267),
      zoom: 16.4746,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: size.height * 0.62,
                // color: Colors.red,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  myLocationEnabled: true,
                  markers: {
                    Marker(
                      markerId: const MarkerId('MarkerId1'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure,
                      ),
                      position: LatLng(
                        -9.484502147032755,
                        -78.27551019958267,
                      ),
                    )
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.04,
                color: Colors.amber,
                child: Center(
                    child: Text('Derrumbes',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 8),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.all(16),
                            child: const Icon(Icons.gps_fixed)),
                        const Expanded(
                          child: Text('Ctra. Panamericana Nte., 02660'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.all(16),
                            child: const Icon(Icons.hourglass_bottom)),
                        const Expanded(
                          child: Text('18:37 pm'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.all(16),
                            child: const Icon(Icons.report_problem_rounded)),
                        const Expanded(
                          child:
                              Text('Accdiente en puente, trafico de 2 horas'),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 25),
                    // ButtonCustom1Widget(
                    //   text: 'LLamar',
                    //   onPressed: () {},
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
