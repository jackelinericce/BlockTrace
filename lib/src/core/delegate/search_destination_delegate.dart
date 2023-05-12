import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';

class SearchDestinationDelegate
    extends SearchDelegate<SearchDestinationMapBox?> {
  final double lat;
  final double lng;

  SearchDestinationDelegate({
    required this.lat,
    required this.lng,
  }) : super(
          searchFieldLabel: 'Buscar dirección',
        );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return Container();
    // String url =
    //     'https://api.mapbox.com/geocoding/v5/mapbox.places/${query}.json?country=pe&language=es&proximity=${lng},${lat}&access_token=pk.eyJ1IjoiZGFzaDEyOCIsImEiOiJja2U3Zmw3YzIwdXBwMnNyM2t6bThybXlxIn0.JgcaqxQE0PRfZZQA7cGbQA';
    // print(url);

    return FutureBuilder(
      future: findSuggestionInMapBox(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Feature>? res = snapshot.data;
        print('future return ${res}');
        if (res == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: res.length,
          itemBuilder: (_, i) {
            return Container(
              child: ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(res[i].placeName),
                onTap: () async {
                  close(
                      context,
                      SearchDestinationMapBox(
                        lat: res[i].center[1],
                        lng: res[i].center[0],
                        text: res[i].placeName,
                      ));
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
    // return ListView.builder(
    //   itemCount: 6,
    //   itemBuilder: (_, i) {
    //     return Container(
    //       child: ListTile(
    //         leading: const Icon(Icons.location_on_outlined),
    //         title: Text('index $i'),
    //       ),
    //     );
    //   },
    // );
  }

  Future<List<Feature>> findSuggestionInMapBox() async {
    try {
      if (query.isEmpty) return [];
      String url =
          'https://api.mapbox.com/geocoding/v5/mapbox.places/${query}.json?country=pe&language=es&proximity=${lng},${lat}&access_token=pk.eyJ1IjoiZGFzaDEyOCIsImEiOiJja2U3Zmw3YzIwdXBwMnNyM2t6bThybXlxIn0.JgcaqxQE0PRfZZQA7cGbQA';
      print(url);
      final response = await Dio().get(url);
      print('response');
      print(response);
      PlaceResponse res = PlaceResponse.fromJson(response.data);
      print('PlaceResponse');
      print(response);
      return res.features;
    } catch (e) {
      print('response error');
      print(e.toString());
      return [];
    }
  }
}
