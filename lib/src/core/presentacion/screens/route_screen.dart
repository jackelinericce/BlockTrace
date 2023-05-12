import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(
        37.42796133580664,
        -122.085749655962,
      ),
      zoom: 14.4746,
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
        ),
      ),
    );
  }
}
