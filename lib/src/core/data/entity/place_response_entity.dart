// To parse this JSON data, do
//
//     final placeResponse = placeResponseFromJson(jsonString);

import 'dart:convert';

class PlaceResponse {
  final String type;
  final List<String> query;
  final List<Feature> features;
  final String attribution;

  PlaceResponse({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  factory PlaceResponse.fromRawJson(String str) =>
      PlaceResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaceResponse.fromJson(Map<String, dynamic> json) => PlaceResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  final String id;
  final String type;
  final List<String> placeType;
  // final double relevance;
  final Properties properties;
  final String textEs;
  final Language? languageEs;
  final String placeNameEs;
  final String text;
  final Language? language;
  final String placeName;
  final List<double> center;
  final Geometry geometry;
  // final List<Context> context;

  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    // required this.relevance,
    required this.properties,
    required this.textEs,
    this.languageEs,
    required this.placeNameEs,
    required this.text,
    this.language,
    required this.placeName,
    required this.center,
    required this.geometry,
    // required this.context,
  });

  factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        // relevance: json["relevance"]?.toDouble(),
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        languageEs: json["language_es"] == null
            ? null
            : languageValues.map[json["language_es"]],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: json["language"] == null
            ? null
            : languageValues.map[json["language"]]!,
        placeName: json["place_name"],

        center: List<double>.from(json["center"].map((x) => x?.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        // context:
        //     List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        // "relevance": relevance,
        "properties": properties.toJson(),
        "text_es": textEs,
        "language_es": languageValues.reverse[languageEs],
        "place_name_es": placeNameEs,
        "text": text,
        "language": languageValues.reverse[language],
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        // "context": List<dynamic>.from(context.map((x) => x.toJson())),
      };
}

// class Context {
//   final String id;
//   final String? shortCode;
//   final String? wikidata;
//   final String mapboxId;
//   final String textEs;
//   final Language? languageEs;
//   final String text;
//   final Language? language;

//   Context({
//     required this.id,
//     this.shortCode,
//     this.wikidata,
//     required this.mapboxId,
//     required this.textEs,
//     this.languageEs,
//     required this.text,
//     this.language,
//   });

//   factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Context.fromJson(Map<String, dynamic> json) => Context(
//         id: json["id"],
//         shortCode: json["short_code"],
//         wikidata: json["wikidata"],
//         mapboxId: json["mapbox_id"],
//         textEs: json["text_es"],
//         languageEs: languageValues.map[json["language_es"]]!,
//         text: json["text"],
//         language: languageValues.map[json["language"]]!,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "short_code": shortCode,
//         "wikidata": wikidata,
//         "mapbox_id": mapboxId,
//         "text_es": textEs,
//         "language_es": languageValues.reverse[languageEs],
//         "text": text,
//         "language": languageValues.reverse[language],
//       };
// }

enum Language { ES }

final languageValues = EnumValues({"es": Language.ES});

class Geometry {
  final String type;
  final List<double> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromRawJson(String str) =>
      Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  final String? wikidata;
  final String? mapboxId;
  final String? foursquare;
  final bool? landmark;
  final String? address;
  final String? category;

  Properties({
    this.wikidata,
    this.mapboxId,
    this.foursquare,
    this.landmark,
    this.address,
    this.category,
  });

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"],
        mapboxId: json["mapbox_id"],
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "wikidata": wikidata,
        "mapbox_id": mapboxId,
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
