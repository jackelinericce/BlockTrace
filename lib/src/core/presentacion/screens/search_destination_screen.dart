import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/delegate/search_destination_delegate.dart';
import 'package:stotppub/src/core/presentacion/providers/map_ubication_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class SearchDestinationScreen extends ConsumerStatefulWidget {
  const SearchDestinationScreen({super.key});

  @override
  SearchDestinationScreenState createState() => SearchDestinationScreenState();
}

class SearchDestinationScreenState
    extends ConsumerState<SearchDestinationScreen> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  @override
  void initState() {
    super.initState();
    // final position = await _geolocatorPlatform.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
        future: getCurrentePosition(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Position? positionCurrent = snapshot.data;
          if (positionCurrent == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          CameraPosition _positionCamera = CameraPosition(
            target: LatLng(
              positionCurrent.latitude,
              positionCurrent.longitude,
            ),
            zoom: 14.4746,
          );
          // ref.read(cmrUbicationProvider.notifier).state = _positionCamera;
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                mapToolbarEnabled: true,
                initialCameraPosition: _positionCamera,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                onCameraMove: (CameraPosition pos) {
                  ref
                      .read(cmrUbicationProvider.notifier)
                      .update((state) => pos);
                },
              ),
              SafeArea(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(top: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: GestureDetector(
                    onTap: () async {
                      var destination = await showSearch(
                        context: context,
                        delegate: SearchDestinationDelegate(
                          lat: positionCurrent.latitude,
                          lng: positionCurrent.longitude,
                        ),
                      );
                      if (destination == null) return;
                      // ref.context.pop({
                      //   "lat": destination.lat,
                      //   "lng": destination.lng,
                      //   "txt":sbdb
                      // });
                      ref.context.pop(destination);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Center(
                          child: Text('Buscar'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    Center(
                      child: Transform.translate(
                        offset: const Offset(0, -15),
                        child: const Icon(
                          Icons.location_on_rounded,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 15,
                child: Container(
                  height: 45,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ButtonCustom1Widget(
                    text: 'Confirmar',
                    onPressed: () async {
                      CameraPosition pos = ref.read(cmrUbicationProvider);

                      var resDialog = await showDialog<bool>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Ubicación'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                SizedBox(height: 15),
                                Text(
                                    'Seguro que desea registrar esta ubicación'),
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
                        },
                      );

                      if (resDialog == true) {
                        if (pos.target.latitude == 0.0) {
                          ref.context.pop(
                            SearchDestinationMapBox(
                                lat: positionCurrent.latitude,
                                lng: positionCurrent.longitude,
                                text: 'ubigeo'),
                          );
                        } else {
                          ref.context.pop(
                            SearchDestinationMapBox(
                                lat: pos.target.latitude,
                                lng: pos.target.longitude,
                                text: 'ubigeo'),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<Position> getCurrentePosition() async {
    return await _geolocatorPlatform.getCurrentPosition();
  }
}
