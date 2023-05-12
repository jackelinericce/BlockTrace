import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final latUbicationProvider = StateProvider<double>((ref) => 0.0);
final lngUbicationProvider = StateProvider<double>((ref) => 0.0);
final txtUbicationProvider = StateProvider<String>((ref) => '');
final cmrUbicationProvider = StateProvider<CameraPosition>(
    (ref) => CameraPosition(target: LatLng(0.0, 0.0)));
